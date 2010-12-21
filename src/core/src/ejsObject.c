/**
    ejsObject.c - Object class

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */

/********************************** Includes **********************************/

#include    "ejs.h"

/****************************** Forward Declarations **************************/

static EjsObj   *obj_defineProperty(Ejs *ejs, EjsObj *type, int argc, EjsObj **argv);

/************************************* Code ***********************************/
/*
    function get constructor(): Object
 */
static EjsObj *obj_constructor(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    EjsObj      *constructor;

    if ((constructor = ejsGetPropertyByName(ejs, obj, EN("constructor"))) != 0) {
        return constructor;
    }
    return (EjsObj*) TYPE(obj);
}


/*
    function get prototype(): Object

    The prototype method is special. It is declared as static so it is generated in the type slots, but it is
    patched to be an instance method so the value of "this" will be preserved when it is invoked.
 */
static EjsObj *obj_prototype(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    EjsFunction     *fun;
    EjsType         *type;
    EjsPot          *prototype;

    if (ejs->compiling) {
        mprAssert(0);
        prototype = ejs->undefinedValue;
        
    } else if (ejsIsType(ejs, obj)) {
        prototype = ((EjsType*) obj)->prototype;
        
    } else if (ejsIsFunction(ejs, obj)) {
        fun = (EjsFunction*) obj;
        if (fun->archetype) {
            prototype = fun->archetype->prototype;
        
        } else {
            type = ejsCreateArchetype(ejs, fun, NULL);
            prototype = type->prototype;
        }
    } else {
        prototype = ejs->undefinedValue;
    }
    return (EjsObj*) prototype;
}


/*
    function set prototype(p: Object): Void
 */
static EjsObj *obj_set_prototype(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    EjsPot          *prototype;
    EjsFunction     *fun;

    if (ejs->compiling) {
        mprAssert(0);
        return ejs->undefinedValue;
    }
    prototype = (EjsPot*) argv[0];
    if (ejsIsType(ejs, obj)) {
        ((EjsType*) obj)->prototype = prototype;
    } else {
        if (ejsIsFunction(ejs, obj)) {
            fun = (EjsFunction*) obj;
            if (ejsIsType(ejs, fun->archetype)) {
                fun->archetype->prototype = prototype;
            } else {
                ejsCreateArchetype(ejs, fun, prototype);
            }
        } else {
            /*
                Normal property creation. This "prototype" property is not used internally.
             */
            ejsSetPropertyByName(ejs, obj, EN("prototype"), prototype);
        }
    }
    return 0;
}


/*
    function clone(deep: Boolean = true) : Object
 */
static EjsObj *obj_clone(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    bool    deep;

    deep = (argc == 1 && argv[0] == (EjsObj*) ejs->trueValue);
    return ejsClone(ejs, obj, deep);
}


/*
    static function create(proto: Object, props: Object = undefined): Void 
 */
static EjsObj *obj_create(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsFunction     *constructor;
    EjsObj          *obj, *properties, *options;
    EjsPot          *prototype;
    EjsType         *type;
    EjsName         qname;
    int             count, slotNum;

    prototype = (EjsPot*) argv[0];
    properties = (argc >= 1) ? argv[1] : 0;

    if (ejsIsType(ejs, prototype)) {
        type = (EjsType*) prototype;
    } else {
        constructor = ejsGetPropertyByName(ejs, prototype, EN("constructor"));
        if (constructor) {
            if (ejsIsType(ejs, constructor)) {
                type = (EjsType*) constructor;
            } else if (ejsIsFunction(ejs, constructor)) {
                if (constructor->archetype == 0) {
                    if ((type = ejsCreateArchetype(ejs, constructor, prototype)) == 0) {
                        return 0;
                    }
                }
                type = constructor->archetype;
            } else {
                ejsThrowTypeError(ejs, "Bad type for the constructor property. Must be a function or type");
                return 0;
            }

        } else {
            if ((type = ejsCreateArchetype(ejs, NULL, prototype)) == 0) {
                return 0;
            }
            ejsSetPropertyByName(ejs, prototype, EN("constructor"), type);
        }
    }
    obj = ejsCreate(ejs, type, 0);
    if (properties) {
        count = ejsGetPropertyCount(ejs, properties);
        for (slotNum = 0; slotNum < count; slotNum++) {
            qname = ejsGetPropertyName(ejs, properties, slotNum);
            options = ejsGetProperty(ejs, properties, slotNum);
            argv[0] = obj;
            argv[1] = (EjsObj*) qname.name;
            argv[2] = options;
            obj_defineProperty(ejs, (EjsObj*) type, 3, argv);
        }
    }
    return (EjsObj*) obj;
}


/*
    static function defineProperty(obj: Object, prop: String, options: Object): Void
*/
static EjsObj *obj_defineProperty(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsFunction     *fun, *get, *set;
    EjsType         *type;
    EjsObj          *obj, *options, *configurable, *enumerable, *namespace, *value, *writable;
    EjsName         qname;
    int             attributes, slotNum;

    mprAssert(argc == 3);

    obj = argv[0];
    if (!ejsIsPot(ejs, obj)) {
        ejsThrowTypeError(ejs, "Object is not configurable");
        return NULL;
    }
    qname.name = (EjsString*) argv[1];
    qname.space = ejs->emptyString;
    options = argv[2];
    value = 0;
    set = get = 0;
    attributes = 0;

    if ((namespace = ejsGetPropertyByName(ejs, options, EN("namespace"))) != 0) {
        qname.space = (EjsString*) namespace;
    }
    if ((slotNum = ejsLookupProperty(ejs, obj, qname)) >= 0) {
        if (ejsPropertyHasTrait(ejs, obj, slotNum, EJS_TRAIT_FIXED)) {
            ejsThrowTypeError(ejs, "Property \"%N\" is not configurable", qname);
            return 0;
        }
    }
    type = ejsGetPropertyByName(ejs, options, EN("type"));

    if ((configurable = ejsGetPropertyByName(ejs, options, EN("configurable"))) != 0) {
        if (configurable == (EjsObj*) ejs->falseValue) {
            attributes |= EJS_TRAIT_FIXED;
        }
    }
    if ((enumerable = ejsGetPropertyByName(ejs, options, EN("enumerable"))) != 0) {
        if (enumerable == (EjsObj*) ejs->falseValue) {
            attributes |= EJS_TRAIT_HIDDEN;
        }
    }
    value = ejsGetPropertyByName(ejs, options, EN("value"));
    if (value && type && !ejsIsA(ejs, value, type)) {
        ejsThrowArgError(ejs, "Value is not of the required type");
        return 0;
    }
    if ((get = ejsGetPropertyByName(ejs, options, EN("get"))) != 0) {
        if (ejsIsFunction(ejs, get)) {
            EjsName qset = { qname.space, ejsCreateStringFromAsc(ejs, "set") };
            get->setter = ejsGetPropertyByName(ejs, obj, qset);
            attributes |= EJS_TRAIT_GETTER;
        } else {
            ejsThrowArgError(ejs, "The \"get\" property is not a function");
            return 0;
        }
    }
    if ((set = ejsGetPropertyByName(ejs, options, EN("set"))) != 0) {
        if (ejsIsFunction(ejs, set)) {
            if (get == 0 && (fun = ejsGetPropertyByName(ejs, obj, qname)) != 0) {
                get = fun;
            }
            if (get) {
                get->setter = set;
            }
        } else {
            ejsThrowArgError(ejs, "The \"set\" property is not a function");
            return 0;
        }
        attributes |= EJS_TRAIT_SETTER;
    }
    if (value && (get || set)) {
        ejsThrowArgError(ejs, "Can't provide a value and getters or setters");
        return 0;
    }
    if (get) {
        value = (EjsObj*) get;
    }
    if ((writable = ejsGetPropertyByName(ejs, options, EN("writable"))) != 0) {
        if (writable == (EjsObj*) ejs->falseValue) {
            attributes |= EJS_TRAIT_READONLY;
        }
    }
    mprAssert((attributes & EJS_TRAIT_MASK) == attributes);
    //  MOB -- go via helper
    if (ejsDefineProperty(ejs, obj, -1, qname, type, attributes, value) < 0) {
        ejsThrowTypeError(ejs, "Can't define property %@", qname.name);
    }
    return 0;
}


/*
    static function freeze(obj: Object): Void
 */
static EjsObj *obj_freeze(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;
    EjsTrait    *trait;
    int         slotNum, numProp;

    obj = (EjsObj*) argv[0];
    DYNAMIC(obj) = 0;
    numProp = ejsGetPropertyCount(ejs, obj);
    for (slotNum = 0; slotNum < numProp; slotNum++) {
        if ((trait = ejsGetPropertyTraits(ejs, obj, slotNum)) != 0) {
            ejsSetPropertyTraits(ejs, obj, slotNum, NULL, trait->attributes | EJS_TRAIT_READONLY | EJS_TRAIT_FIXED);
        }
    }
    if (ejsIsType(ejs, obj)) {
        obj = (EjsObj*) ((EjsType*) obj)->prototype;
        numProp = ejsGetPropertyCount(ejs, obj);
        for (slotNum = 0; slotNum < numProp; slotNum++) {
            if ((trait = ejsGetPropertyTraits(ejs, obj, slotNum)) != 0) {
                ejsSetPropertyTraits(ejs, obj, slotNum, NULL, trait->attributes | EJS_TRAIT_READONLY | EJS_TRAIT_FIXED);
            }
        }
    }
    return 0;
}


/*
    Function to iterate and return the next element name.
    NOTE: this is not a method of Object. Rather, it is a callback function for Iterator.
 */
static EjsObj *nextObjectKey(Ejs *ejs, EjsIterator *ip, int argc, EjsObj **argv)
{
    EjsObj      *obj;
    EjsName     qname;
    EjsTrait    *trait;
    int         numProp;

    obj = ip->target;
    numProp = ejsGetPropertyCount(ejs, obj);
    for (; ip->index < numProp; ip->index++) {
        qname = ejsGetPropertyName(ejs, obj, ip->index);
        if (qname.name == NULL) {
            continue;
        }
        trait = ejsGetPropertyTraits(ejs, obj, ip->index);
        if (trait && trait->attributes & 
            /* MOB OPT - make initializers and deleted items always hidden */
                (EJS_TRAIT_HIDDEN | EJS_TRAIT_DELETED | EJS_FUN_INITIALIZER | EJS_FUN_MODULE_INITIALIZER)) {
            continue;
        }
        ip->index++;
        return (EjsObj*) qname.name;
    }
    ejsThrowStopIteration(ejs);
    return 0;
}


/*
    Return the default iterator.

    iterator function get(options: Object = null): Iterator
 */
static EjsObj *obj_get(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    return (EjsObj*) ejsCreateIterator(ejs, obj, (EjsProc) nextObjectKey, 0, NULL);
}


/*
    Function to iterate and return the next element value.
    NOTE: this is not a method of Object. Rather, it is a callback function for Iterator
 */
static EjsObj *nextObjectValue(Ejs *ejs, EjsIterator *ip, int argc, EjsObj **argv)
{
    EjsObj      *obj;
    EjsTrait    *trait;
    int         numProp;

    obj = ip->target;
    numProp = ejsGetPropertyCount(ejs, obj);
    for (; ip->index < numProp; ip->index++) {
        trait = ejsGetPropertyTraits(ejs, obj, ip->index);
        if (trait && trait->attributes & 
                (EJS_TRAIT_HIDDEN | EJS_TRAIT_DELETED | EJS_FUN_INITIALIZER | EJS_FUN_MODULE_INITIALIZER)) {
            continue;
        }
        return ejsGetProperty(ejs, obj, ip->index++);
    }
    ejsThrowStopIteration(ejs);
    return 0;
}


/*
    Return an iterator to return the next array element value.

    iterator function getValues(options: Object = null): Iterator
 */
static EjsObj *obj_getValues(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    return (EjsObj*) ejsCreateIterator(ejs, obj, (EjsProc) nextObjectValue, 0, NULL);
}


/*
    Get the number of properties in the object.

    function get getOwnPropertyCount(obj): Number
 */
static EjsObj *obj_getOwnPropertyCount(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;

    obj = argv[0];
    return (EjsObj*) ejsCreateNumber(ejs, ejsGetPropertyCount(ejs, obj) - TYPE(obj)->numInherited);
}


/*
    static function getOwnPropertyDescriptor(obj: Object, prop: String): Object
 */
static EjsObj *obj_getOwnPropertyDescriptor(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsFunction     *fun;
    EjsTrait        *trait;
    EjsObj          *obj, *result, *value;
    EjsName         qname, qn;
    EjsType         *type;
    EjsLookup       lookup;
    int             slotNum;

    obj = argv[0];
    //  MOB - ugly
    qname.space = ejs->emptyString;
    qname.name = (EjsString*) argv[1];
    if ((slotNum = ejsLookupVarWithNamespaces(ejs, obj, qname, &lookup)) < 0) {
        return (EjsObj*) ejs->falseValue;
    }
    trait = ejsGetPropertyTraits(ejs, obj, slotNum);
    result = ejsCreateEmptyPot(ejs);
    value = ejsGetVarByName(ejs, obj, qname, &lookup);
    if (value == 0) {
        value = ejs->nullValue;
    }
    type = (trait) ? trait->type: 0;
    if (trait && trait->attributes & EJS_TRAIT_GETTER) {
        ejsSetPropertyByName(ejs, result, EN("get"), value);
    } else if (trait && trait->attributes & EJS_TRAIT_SETTER) {
        fun = (EjsFunction*) value;
        if (ejsIsFunction(ejs, fun)) {
            ejsSetPropertyByName(ejs, result, EN("set"), fun->setter);
        }
    } else if (value) {
        ejsSetPropertyByName(ejs, result, EN("value"), value);
    }
    ejsSetPropertyByName(ejs, result, EN("configurable"), 
        ejsCreateBoolean(ejs, !trait || !(trait->attributes & EJS_TRAIT_FIXED)));
    ejsSetPropertyByName(ejs, result, EN("enumerable"), 
        ejsCreateBoolean(ejs, !trait || !(trait->attributes & EJS_TRAIT_HIDDEN)));
    qn = ejsGetPropertyName(ejs, obj, slotNum);
    ejsSetPropertyByName(ejs, result, EN("namespace"), qn.space);
    ejsSetPropertyByName(ejs, result, EN("type"), type ? (EjsObj*) type : ejs->nullValue);
    ejsSetPropertyByName(ejs, result, EN("writable"), 
        ejsCreateBoolean(ejs, !trait || !(trait->attributes & EJS_TRAIT_READONLY)));
    return result;
}


/*
    Get all properties names including non-enumerable properties

    static function getOwnPropertyNames(obj: Object, options: Object): Array
 */
static EjsObj *obj_getOwnPropertyNames(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj, *options, *arg;
    EjsArray    *result;
    EjsTrait    *trait;
    EjsName     qname;
    int         slotNum, numProp, index, includeBases, excludeFunctions;

    obj = (EjsObj*) argv[0];
    includeBases = 0;
    excludeFunctions = 0;
    if (argc > 0) {
        options = argv[1];
        if ((arg = ejsGetPropertyByName(ejs, options, EN("includeBases"))) != 0) {
            includeBases = (arg == (EjsObj*) ejs->trueValue);
        }
        if ((arg = ejsGetPropertyByName(ejs, options, EN("excludeFunctions"))) != 0) {
            excludeFunctions = (arg == (EjsObj*) ejs->trueValue);
        }
    }
    if ((result = ejsCreateArray(ejs, 0)) == 0) {
        return 0;
    }
    index = 0;
    slotNum = (includeBases) ? 0 : TYPE(obj)->numInherited;
    numProp = ejsGetPropertyCount(ejs, obj);
    for (; slotNum < numProp; slotNum++) {
        if ((trait = ejsGetPropertyTraits(ejs, obj, slotNum)) != 0) {
            if (trait->attributes & (EJS_TRAIT_DELETED | EJS_FUN_INITIALIZER | EJS_FUN_MODULE_INITIALIZER)) {
                continue;
            }
        }
        qname = ejsGetPropertyName(ejs, obj, slotNum);
        if (excludeFunctions && ejsIsFunction(ejs, ejsGetProperty(ejs, obj, slotNum))) {
            continue;
        }
        ejsSetProperty(ejs, result, index++, qname.name);
    }
    if (ejsIsType(ejs, obj) || ejsIsFunction(ejs, obj)) {
        if (ejsLookupProperty(ejs, obj, EN("prototype")) < 0) {
            ejsSetProperty(ejs, result, index++, ejsCreateStringFromAsc(ejs, "prototype"));
        }
        if (ejsLookupProperty(ejs, obj, EN("length")) < 0) {
            ejsSetProperty(ejs, result, index++, ejsCreateStringFromAsc(ejs, "length"));
        }
    } else if (ejsIsPrototype(ejs, obj)) {
        if (ejsLookupProperty(ejs, obj, EN("constructor")) < 0) {
            ejsSetProperty(ejs, result, index++, ejsCreateStringFromAsc(ejs, "constructor"));
        }
    }
    return (EjsObj*) result;
}


/*
    static function getOwnPrototypeOf(obj: Object): Type
 */
static EjsObj *obj_getOwnPrototypeOf(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;

    obj = argv[0];
    return (EjsObj*) TYPE(obj)->prototype;
}


/*
    function hasOwnProperty(name: String): Boolean
 */
static EjsObj *obj_hasOwnProperty(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    EjsName     qname;
    EjsLookup   lookup;
    int         slotNum;

    qname.space = ejs->emptyString;
    qname.name = (EjsString*) argv[0];
    slotNum = ejsLookupVarWithNamespaces(ejs, obj, qname, &lookup);
    return (EjsObj*) ejsCreateBoolean(ejs, slotNum >= 0);
}


/*
    static function isExtensible(obj: Object): Boolean
 */
static EjsObj *obj_isExtensible(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;

    obj = argv[0];
    return (EjsObj*) ejsCreateBoolean(ejs, DYNAMIC(obj));
}


/*
    static function isFrozen(obj: Object): Boolean
 */
static EjsObj *obj_isFrozen(Ejs *ejs, EjsObj *type, int argc, EjsObj **argv)
{
    EjsTrait    *trait;
    EjsPot      *obj;
    int         numProp, frozen, slotNum;

    obj = (EjsPot*) argv[0];
    frozen = 1;
    numProp = ejsGetPropertyCount(ejs, obj);
    for (slotNum = 0; slotNum < numProp; slotNum++) {
        if ((trait = ejsGetPropertyTraits(ejs, obj, slotNum)) != 0) {
            if (!(trait->attributes & EJS_TRAIT_READONLY)) {
                frozen = 0;
                break;
            }
            if (!(trait->attributes & EJS_TRAIT_FIXED)) {
                frozen = 0;
                break;
            }
        }
    }
    if (DYNAMIC(obj)) {
        frozen = 0;
    }
    return (EjsObj*) ejsCreateBoolean(ejs, frozen);
}


/*
    static function isPrototypeOf(obj: Object): Boolean
 */
static EjsObj *obj_isPrototypeOf(Ejs *ejs, EjsObj *prototype, int argc, EjsObj **argv)
{
    EjsObj  *obj;
    
    obj = argv[0];
    return (prototype == ((EjsObj*) TYPE(obj)->prototype)) ? ejs->trueValue : ejs->falseValue;
}


/*
    static function isSealed(obj: Object): Boolean
 */
static EjsObj *obj_isSealed(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsTrait    *trait;
    EjsPot      *obj;
    int         numProp, sealed, slotNum;

    obj = (EjsPot*) argv[0];
    sealed = 1;
    numProp = ejsGetPropertyCount(ejs, obj);
    for (slotNum = 0; slotNum < numProp; slotNum++) {
        if ((trait = ejsGetPropertyTraits(ejs, obj, slotNum)) != 0) {
            if (!(trait->attributes & EJS_TRAIT_FIXED)) {
                sealed = 0;
                break;
            }
        }
    }
    if (DYNAMIC(obj)) {
        sealed = 0;
    }
    return (EjsObj*) ejsCreateBoolean(ejs, sealed);
}


#if FUTURE
/*
    Get enumerable properties names

    static function keys(obj: Object): Array
 */
static EjsObj *obj_keys(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj, *vp;
    EjsArray    *result;
    EjsTrait    *trait;
    EjsName     qname;
    int         numProp, slotNum;

    obj = argv[0];
    numProp = ejsGetPropertyCount(ejs, obj);
    if ((result = ejsCreateArray(ejs, numProp)) == 0) {
        return 0;
    }
    for (slotNum = 0; slotNum < numProp; slotNum++) {
        if ((trait = ejsGetPropertyTraits(ejs, obj, slotNum)) != 0) {
            if (trait->attributes & EJS_TRAIT_DELETED) {
                continue;
            }
        }
        vp = ejsGetProperty(ejs, obj, slotNum);
        qname = ejsGetPropertyName(ejs, obj, slotNum);
        ejsSetProperty(ejs, result, slotNum, ejsCreateStringFromAsc(ejs, qname.name));
    }
    return (EjsObj*) result;
}
#endif


/*
    static function preventExtensions(obj: Object): Object
    MOB -- should this be void return?
 */
static EjsObj *obj_preventExtensions(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;

    obj = argv[0];
    DYNAMIC(obj) = 0;
    return obj;
}


/*
    static function seal(obj: Object): Void
*/
static EjsObj *obj_seal(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;
    EjsTrait    *trait;
    int         slotNum, numProp;

    obj = argv[0];
    numProp = ejsGetPropertyCount(ejs, obj);
    for (slotNum = 0; slotNum < numProp; slotNum++) {
        if ((trait = ejsGetPropertyTraits(ejs, obj, slotNum)) != 0) {
            trait->attributes |= EJS_TRAIT_FIXED;
        }
    }
    DYNAMIC(obj) = 0;
    return 0;
}


/*
    function propertyIsEnumerable(property: String, flag: Object = undefined): Boolean
 */
static EjsObj *obj_propertyIsEnumerable(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    EjsTrait    *trait;
    EjsName     qname;
    EjsLookup   lookup;
    int         slotNum;

    mprAssert(argc == 1 || argc == 2);

    qname.space = ejs->emptyString;
    qname.name = (EjsString*) argv[0];
    if ((slotNum = ejsLookupVarWithNamespaces(ejs, obj, qname, &lookup)) < 0) {
        return (EjsObj*) ejs->falseValue;
    }
    trait = ejsGetPropertyTraits(ejs, obj, slotNum);
    return (EjsObj*) ejsCreateBoolean(ejs, !trait || !(trait->attributes & EJS_TRAIT_HIDDEN));
}


/*
    Convert the object to a JSON string. This also handles Json for Arrays.

    function toJSON(options: Object = null): String
 */
EjsString *ejsObjToJSON(Ejs *ejs, EjsObj *vp, int argc, EjsObj **argv)
{
    return ejsSerialize(ejs, vp, (argc == 1) ? argv[0] : NULL);
}


#if ES_Object_toLocaleString
/*
    Convert the object to a localized string

    function toLocaleString(): String
 */
static EjsString *toLocaleString(Ejs *ejs, EjsObj *vp, int argc, EjsObj **argv)
{
    return ejsObjToString(ejs, vp, argc, argv);
}
#endif


EjsString *ejsObjToString(Ejs *ejs, EjsObj *vp, int argc, EjsObj **argv)
{
    if (ejsIsString(ejs, vp)) {
        return (EjsString*) vp;
    }
    return (ejs->objHelpers.cast)(ejs, vp, ejs->stringType);
}


/************************************************** Reflection **********************************************/
/*
    Get the base class of the object.

    function getBaseType(obj: Type): Type
 */
static EjsObj *obj_getBaseType(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *vp;

    vp = argv[0];
    if (ejsIsType(ejs, vp)) {
        return (EjsObj*) (((EjsType*) vp)->baseType);
    }
    return (EjsObj*) ejs->nullValue;
}


/*
    function isPrototype(obj: Object): Boolean
 */
static EjsObj *obj_isPrototype(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    return (EjsObj*) ejsCreateBoolean(ejs, ejsIsPrototype(ejs, argv[0]));
}


/*
    function isType(obj: Object): Boolean
 */
static EjsObj *obj_isType(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    return (EjsObj*) ejsCreateBoolean(ejs, ejsIsType(ejs, argv[0]));
}


/*
    Get the type of the object.

    function getType(obj: Object): Type
 */
static EjsObj *obj_getType(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;

    obj = argv[0];
    return (EjsObj*) TYPE(obj);
}

//  MOB - move out of here
/*
    Return the name of the type of an object. If the obj is a type, get the base type.
 */
EjsString *ejsGetTypeName(Ejs *ejs, EjsAny *obj)
{
    EjsType     *type;

    if (obj == 0) {
        return ejs->undefinedValue;
    }
    type = (EjsType*) TYPE(obj);
    if (type == 0) {
        return ejs->nullValue;
    }
    return type->qname.name;
}


/*
    function getTypeName(obj): String
 */
static EjsObj *obj_getTypeName(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    mprAssert(argc >= 1);
    return (EjsObj*) ejsGetTypeName(ejs, argv[0]);
}


/*
    Get the name of a function or type object

    function getName(obj: Object): String
 */
static EjsObj *obj_getName(Ejs *ejs, EjsObj *unused, int argc, EjsObj **argv)
{
    EjsObj      *obj;

    obj = argv[0];

    if (ejsIsType(ejs, obj)) {
        return (EjsObj*) ((EjsType*) obj)->qname.name;
    } else if (ejsIsFunction(ejs, obj)) {
        return (EjsObj*) ((EjsFunction*) obj)->name;
    }
    return (EjsObj*) ejs->emptyString;
}

/*********************************** Globals **********************************/
/*
    function typeOf(obj): String
 */
static EjsObj *obj_typeOf(Ejs *ejs, EjsObj *obj, int argc, EjsObj **argv)
{
    mprAssert(argc >= 1);
    return (EjsObj*) ejsGetTypeName(ejs, argv[0]);
}


//  MOB -- move out of here
/*
    Get the ecma "typeof" value for an object. Unfortunately, typeof is pretty lame.
 */
EjsString *ejsGetTypeOf(Ejs *ejs, EjsAny *vp)
{
    cchar   *word;

    if (vp == ejs->undefinedValue) {
        word = "undefined";

    } else if (vp == ejs->nullValue) {
        /* Yea - I know, ECMAScript is broken */
        word = "object";

    } if (ejsIsBoolean(ejs, vp)) {
        word = "boolean";

    } else if (ejsIsNumber(ejs, vp)) {
        word = "number";

    } else if (ejsIsString(ejs, vp)) {
        word = "string";

    } else if (ejsIsFunction(ejs, vp)) {
        word = "function";
               
    } else if (ejsIsType(ejs, vp)) {
        /* Pretend it is a constructor function */
        word = "function";
               
    } else {
        word = "object";
    }
    return ejsCreateStringFromAsc(ejs, word);
}


void ejsConfigureObjectType(Ejs *ejs)
{
    EjsType     *type;
    EjsPot      *prototype;
    EjsFunction *fun;

    type = ejs->objectType;
    prototype = type->prototype;

    ejsBindMethod(ejs, type, ES_Object_create, obj_create);
    ejsBindMethod(ejs, type, ES_Object_defineProperty, obj_defineProperty);
    ejsBindMethod(ejs, type, ES_Object_freeze, obj_freeze);
    ejsBindMethod(ejs, type, ES_Object_getOwnPropertyCount, obj_getOwnPropertyCount);
    ejsBindMethod(ejs, type, ES_Object_getOwnPropertyDescriptor, obj_getOwnPropertyDescriptor);
    ejsBindMethod(ejs, type, ES_Object_getOwnPropertyNames, obj_getOwnPropertyNames);
    ejsBindMethod(ejs, type, ES_Object_getOwnPrototypeOf, obj_getOwnPrototypeOf);
    ejsBindMethod(ejs, type, ES_Object_isExtensible, obj_isExtensible);
    ejsBindMethod(ejs, type, ES_Object_isFrozen, obj_isFrozen);
    ejsBindMethod(ejs, type, ES_Object_isSealed, obj_isSealed);
    ejsBindMethod(ejs, type, ES_Object_preventExtensions, obj_preventExtensions);
    ejsBindAccess(ejs, type, ES_Object_prototype, (EjsProc) obj_prototype, obj_set_prototype);
    ejsBindMethod(ejs, type, ES_Object_seal, obj_seal);

    /* Reflection */
    ejsBindMethod(ejs, type, ES_Object_getBaseType, obj_getBaseType);
    ejsBindMethod(ejs, type, ES_Object_getType, obj_getType);
    ejsBindMethod(ejs, type, ES_Object_getTypeName, obj_getTypeName);
    ejsBindMethod(ejs, type, ES_Object_getName, obj_getName);
    ejsBindMethod(ejs, type, ES_Object_isPrototype, obj_isPrototype);
    ejsBindMethod(ejs, type, ES_Object_isType, obj_isType);

    ejsBindMethod(ejs, prototype, ES_Object_constructor, (EjsProc) obj_constructor);
    ejsBindMethod(ejs, prototype, ES_Object_clone, obj_clone);
    ejsBindMethod(ejs, prototype, ES_Object_iterator_get, obj_get);
    ejsBindMethod(ejs, prototype, ES_Object_iterator_getValues, obj_getValues);
    ejsBindMethod(ejs, prototype, ES_Object_hasOwnProperty, obj_hasOwnProperty);
    ejsBindMethod(ejs, prototype, ES_Object_isPrototypeOf, obj_isPrototypeOf);
    ejsBindMethod(ejs, prototype, ES_Object_propertyIsEnumerable, obj_propertyIsEnumerable);
    ejsBindMethod(ejs, prototype, ES_Object_toLocaleString, toLocaleString);
    ejsBindMethod(ejs, prototype, ES_Object_toString, ejsObjToString);
    ejsBindMethod(ejs, prototype, ES_Object_toJSON, ejsObjToJSON);

    ejsBindFunction(ejs, ejs->global, ES_typeOf, (EjsProc) obj_typeOf);

    /*
        The prototype method is special. It is declared as static so it is generated in the type slots, but it is
        patched to be an instance method so the value of "this" will be preserved when it is invoked.
     */
    fun = ejsGetProperty(ejs, (EjsObj*) type, ES_Object_prototype);
    fun->staticMethod = 0;
    fun->setter->staticMethod = 0;
    type->constructor.block.pot.properties->slots[ES_Object_prototype].trait.attributes &= ~EJS_PROP_STATIC;
}

/*
    @copy   default

    Copyright (c) Embedthis Software LLC, 2003-2010. All Rights Reserved.
    Copyright (c) Michael O'Brien, 1993-2010. All Rights Reserved.

    This software is distributed under commercial and open source licenses.
    You may use the GPL open source license described below or you may acquire
    a commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.TXT distributed with
    this software for full details.

    This software is open source; you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation; either version 2 of the License, or (at your
    option) any later version. See the GNU General Public License for more
    details at: http://www.embedthis.com/downloads/gplLicense.html

    This program is distributed WITHOUT ANY WARRANTY; without even the
    implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    This GPL license does NOT permit incorporating this software into
    proprietary programs. If you are unable to comply with the GPL, you must
    acquire a commercial license to use this software. Commercial licenses
    for this software and support services are available from Embedthis
    Software at http://www.embedthis.com

    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=8 ts=8 expandtab

    @end
 */

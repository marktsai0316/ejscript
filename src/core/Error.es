/*
    Error.es -- Error exception classes

    Copyright (c) All Rights Reserved. See copyright notice at the bottom of the file.
 */

module ejs {

    /**
        Error exception object and base class. Exception objects are created by the system as part of changing 
        the normal flow of execution when some error condition occurs. 

        When an exception is triggered and acted upon ("thrown"), the system transfers the flow of control to a 
        pre-defined instruction stream (the handler or "catch" code). The handler may return processing to the 
        point execution block where the exception was thrown. It may re-throw the exception or pass control up 
        the call stack for an outer handler to process.
        @stability evolving
     */
    dynamic class Error {

        use default namespace public

        /** 
            Source filename of the script that created the error
         */
        function get filename(): Path
            Path(stack[0].filename)

        /** 
            Source line number in the script that created the error
         */
        function get lineno(): Number
            stack[0].lineno

        /**
            Supplemental error data
         */
        enumerable var data: Object

        /**
            Error message
         */
        enumerable var message: String

        /**
            Callback stack
         */
        enumerable var stack: Array

        /** 
            Time the event was created. The Context constructor will automatically set the timestamp to the current time.  
         */
        enumerable var timestamp: Date

        /**
            Optional error code
         */
        enumerable var code: Number

        /**
            Construct a new Error object.
            @params message Message to use when defining the Error.message property. Typically a string but can be an
                object of any type.
         */
        native function Error(message: String? = null)

        /**
            Capture the stack. This call captures the stack and returns an Array describing the current stack frame.
            @param uplevels Skip a given count of stack frames from the stop of the call stack.
         */
        native static function capture(uplevels: Number = 0): Array

        /**
            Format the captured stack
            @return A string containing the formatted stack backtrace. Format is:
                [INDEX FILENAME, line LINENO, FUNCTION, CODE_LINE]
         */
        function formatStack(): String {
            let result = ""
            let i = 0
            for each (frame in stack) {
                if (frame.filename) {
                    result += " [%02d] %s, line %d, %s, %s\n".format(
                        i++, frame.filename, frame.lineno, frame.func, frame.code)
                } else {
                    result += " [%02d] %s\n".format(i++, frame.func)
                }
            }
            return result
        }
    }

    /**
        Arguments error exception class. 
        Thrown when function arguments are not compatible with the required function parameters.
        @spec ejs
        @stability evolving
     */
    dynamic class ArgError extends Error {
        /**
            ArgError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function ArgError(message: String? = null) 
    }

    /**
        Arithmetic error exception class. Thrown when the system cannot perform an arithmetic or math operation, 
        @spec ejs
        @stability evolving
     */
    dynamic class ArithmeticError extends Error {
        /**
            ArithmeticError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function ArithmeticError(message: String? = null) 
    }

    /**
        Assertion error exception class. Thrown when the $global.assert method is invoked with a false value.
        @spec ejs
        @stability evolving
     */
    dynamic class AssertError extends Error {
        /**
            AssertError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function AssertError(message: String? = null) 
    }

//UNUSED Who is using this? Delete
    /**
        Code (instruction) error exception class. Thrown when an illegal or insecure operation code is detected 
        in the instruction stream.
        @spec ejs
        @stability evolving
     */
    dynamic class InstructionError extends Error {
        /**
            InstructionError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function InstructionError(message: String? = null) 
    }

    /**
        IO error exception class. Thrown when an I/O/ interruption or failure occurs, e.g. a file is not found 
        or there is an error in a communication stack.
        @spec ejs
        @stability evolving
     */
    dynamic class IOError extends Error {
        /**
            IOError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function IOError(message: String? = null) 
    }

    /**
        Internal error exception class. Thrown when some error occurs in the virtual machine.
        @spec ejs
        @stability evolving
        @hide
     */
    dynamic class InternalError extends Error {
        /**
            InternalError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function InternalError(message: String? = null) 
    }

    /**
        Memory error exception class. Thrown when the system attempts to allocate memory and none is available 
        or the stack overflows.
        @spec ejs
        @stability evolving
     */
    dynamic class MemoryError extends Error {
        /**
            MemoryError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function MemoryError(message: String? = null) 
    }

//UNUSED Who is using this? Delete
    /**
        OutOfBounds error exception class. Thrown to indicate that an attempt has been made to set or access an 
        object's property outside of the permitted set of values for that property. For example, an array has been 
        accessed with an illegal index or, in a date object, attempting to set the day of the week to greater then 7.
        @spec ejs
        @stability evolving
        @hide
     */
    dynamic class OutOfBoundsError extends Error {
        /**
            OutOfBoundsError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function OutOfBoundsError(message: String? = null) 
    }

    /**
        Reference error exception class. Thrown when an invalid reference to an object is made, e.g. a method is 
        invoked on an object whose type does not define that method.
        @stability evolving
     */
    dynamic class ReferenceError extends Error {
        /**
            ReferenceError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function ReferenceError(message: String? = null)
    }

    /**
        Resource error exception class. Thrown when the system cannot allocate a resource it needs to continue, 
        e.g. a native thread, process, file handle or the like.
        @spec ejs
        @stability evolving
     */
    dynamic class ResourceError extends Error {
        /**
            ResourceError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function ResourceError(message: String? = null) 
    }

    /**
        Security error exception class. Thrown when an access violation occurs. Access violations include attempting 
        to write a file without having write permission or assigning permissions without being the owner of the 
        securable entity.
        @spec ejs
        @stability evolving
        @hide
     */
    dynamic class SecurityError extends Error {
        /**
            SecurityError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function SecurityError(message: String? = null) 
    }

    /**
        State error exception class. Thrown when an object cannot be transitioned from its current state to the 
        desired state.
        @spec ejs
        @stability evolving
     */
    dynamic class StateError extends Error {
        /**
            StateError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function StateError(message: String? = null) 
    }

    /**
        Syntax error exception class. Thrown when the system cannot parse a character sequence for the intended 
        purpose, e.g. a regular expression containing invalid characters.
        @stability evolving
     */
    dynamic class SyntaxError extends Error {
        /**
            SyntaxError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function SyntaxError(message: String? = null) 
    }

    /**
        Type error exception class. Thrown when a type casting or creation operation fails, e.g. when an operand 
        cannot be cast to a required parameter type.
        @stability evolving
     */
    dynamic class TypeError extends Error {
        /**
            TypeError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function TypeError(message: String? = null) 
    }

//UNUSED Delete
    /**
        Uri error exception class. Throw a Uri fails to parse.
        @stability prototype
        @hide
     */
    dynamic class URIError extends Error {
        /**
            URIError constructor.
            @params message Message to use when defining the Error.message property
         */
        native function URIError(message: String? = null) 
    }
}


/*
    @copy   default

    Copyright (c) Embedthis Software. All Rights Reserved.

    This software is distributed under commercial and open source licenses.
    You may use the Embedthis Open Source license or you may acquire a 
    commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.md distributed with
    this software for full details and other copyrights.

    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=4 ts=4 expandtab

    @end
 */

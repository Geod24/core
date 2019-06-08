module exec.iexecprovider;

import std.typecons: Tuple;

alias Package = Tuple!(string, "name", string, "version_");

/++
	Interface for exec providers that take source code
	and output the compiled program's output.
+/
interface IExecProvider
{
	struct RunInput
	{
		string source;
		string args;
		string stdin;
		bool color;

        @property string compiler () nothrow @nogc pure @safe const
        {
            assert(this.compiler_.length);
            return this.compiler_;
        }
        @property void compiler (string val) nothrow @nogc pure @safe
        {
            this.compiler_ = val;
        }
        private string compiler_;
	}
	Tuple!(string, "output", bool, "success") compileAndExecute(RunInput input);


	// returns a list of all installed DUB packages
	Package[] installedPackages();
}

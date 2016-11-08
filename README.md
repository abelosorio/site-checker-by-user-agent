Site checker by user agent
================

Check site accessibility by using a list of User Agents. The default list is downloaded from Christophe Vandeplas's [repository](https://github.com/cvandeplas/pystemon).

Check is done by using wget and results are printed to standard output with the wget's exit status text.

Contributors
----------------

* Abel M. Osorio [abel.m.osorio at gmail dot com]

TODO
-------

* Improve output (eg: sumary).
* Allow to use another User Agent list (eg: --user-agent-file).
* Resume checking from last checked (eg: --resume).
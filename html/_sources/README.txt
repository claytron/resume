README
====================================================================

See It
--------------------------------------------------------------------

https://claytron.github.io/resume

Build It
--------------------------------------------------------------------

First, a few things need to be done.

Install `wkhtmltopdf <http://wkhtmltopdf.org/>`_.

I'll assume there is a Python install with virtualenv.
Get one setup for this and pull in the dependencies::

    $ make venv

Now create a pdf::

    $ make pdf

Or push the latest changes to github::

    $ make publish

Or do whatever else sphinx can do.

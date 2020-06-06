README
====================================================================

See It
--------------------------------------------------------------------

https://claytron.github.io/resume

And believe it.

https://github.com/claytron/resume

Build It
--------------------------------------------------------------------

First, a few things need to be done.

Create a `gh-pages branch <https://help.github.com/articles/creating-project-pages-manually/>`_

Install `wkhtmltopdf <http://wkhtmltopdf.org/>`_.

I'll assume there is a Python install with virtualenv.
Get one setup for this and pull in the dependencies::

    $ make venv
    $ source env/bin/activate
    $ pip install -r requirements.txt

Now create a pdf::

    (env)$ make pdf

Or push the latest changes to github::

    (env)$ make publish

Or do whatever else sphinx can do.

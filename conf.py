# -*- coding: utf-8 -*-
extensions = [
    'sphinx.ext.todo',
    'sphinxcontrib.gravatar',
    'rst2pdf.pdfbuilder',
]
templates_path = ['_templates']
source_suffix = ['.rst', '.md']
master_doc = 'index'
project = u'resume'
copyright = '2015, Clayton Parker'
author = u'Clayton Parker'
language = None

# There are two options for replacing |today|: either, you set today to some
# non-false value, then it is used:
#today = ''
# Else, today_fmt is used as the format for a strftime call.
#today_fmt = '%B %d, %Y'

exclude_patterns = ['_build']
pygments_style = 'sphinx'
todo_include_todos = True

gravatar_users = (
    ('claytron', {'email': 'clayton@sixfeetup.com'}),
)

import sphinx_bootstrap_theme
html_theme = 'bootstrap'
html_theme_path = sphinx_bootstrap_theme.get_html_theme_path()

# (Optional) Logo. Should be small enough to fit the navbar (ideally 24x24).
# Path should be relative to the ``_static`` files directory.
#html_logo = "my_logo.png"

# Theme options are theme-specific and customize the look and feel of a
# theme further.
html_theme_options = {
    'navbar_title': "Clayton Parker | Software Engineer",
    'navbar_site_name': "Site",
    'navbar_links': [
    ],
    'navbar_sidebarrel': True,
    'navbar_pagenav': False,
    'navbar_pagenav_name': "Sections",
    'globaltoc_depth': 2,
    'globaltoc_includehidden': "true",
    'navbar_class': "navbar navbar-inverse",
    'navbar_fixed_top': "true",
    'source_link_position': 'footer',
    'bootswatch_theme': "superhero",
    'bootstrap_version': "3",
}

# The name for this set of Sphinx documents.  If None, it defaults to
# "<project> v<release> documentation".
html_title = 'Resume'

# The name of an image file (within the static path) to use as favicon of the
# docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
#html_favicon = None

html_static_path = ['_static']

# If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
# using the given strftime format.
html_last_updated_fmt = '%b %d, %Y'

# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
html_show_sphinx = False

# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
html_show_copyright = False

# Output file base name for HTML help builder.
htmlhelp_basename = 'resumedoc'

# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'resume', u'resume Documentation',
     [author], 1)
]

# -- Options for PDF output -----------------------------------------------

pdf_documents = [
    ('index', u'Resume', u'Resume2', u'Clayton Parker'),
]

pdf_use_coverpage = False
pdf_use_index = False
pdf_use_modindex = False
pdf_use_toc = False

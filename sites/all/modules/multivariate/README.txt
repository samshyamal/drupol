
AUTHOR
------
Jimmy Berry ("boombatower", http://drupal.org/user/214218)

PROJECT PAGE
------------
If you need more information, have an issue, or feature request please
visit the project page at: http://drupal.org/project/multivariate.

DESCRIPTION
-----------
This module provides a simple interface for setting up multivariate or A/B
style studies that can be performed on a live sites to test the effectiveness
of various interfaces.

Multivariate
Any portion of Drupal may be modified using the hooks and mechanisms already in
place. The modifications may be based on multivariate mutations. Once a
mutation set is requested the same set will be used for the entire user
session. The mutation information may be used to make any modification to forms
and such. An example multivariate mutation is provided in
multivariate.mutation.inc and demonstrates how simple it is.

A/B
Setting up an A/B style test is very simple and only requires the original URL,
and any variation URLs. When a user visits the original URL a mutation will be
selected that will either redirect them to one of the variations or leave them
on the original URL. The same mutation will be used for the entire user
session.

Success
Success is counted when a user visits the success URL specified in the study
details. For example, this could be a page that the user is redirected to after
they buy a product. If a more complex success condition is required the module
provides a hook, described in multivariate.hook.inc, for defining complex
conditions.

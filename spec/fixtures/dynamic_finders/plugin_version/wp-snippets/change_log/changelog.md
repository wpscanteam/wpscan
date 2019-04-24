= v150201 =

* Reformat source code; general cleanup.
* Compatibility with WordPress v4.1 and v4.2-alpha.
* Bug fix in hook/filter handling. See: [this GitHub issue](https://github.com/websharks/wp-snippets/pull/2) for further details.

= v131121 =

* Adding support for `[snippet_template slug="" /]`. This works the same as a normal `[snippet slug="" /]` shortcode; except with a Snippet Template shortcode, any additional attributes that you specify are used as replacement code values in the Snippet content. For instance, you might have a Snippet with content that includes this replacement code: `%%type%%`. Now create your Snippet shortcode like this to fill that value dynamically: `[snippet_template slug="my-slug" type="product" /]`; where `%%type%%` is now replaced by `product` dynamically.

= v130206 =

* Initial release.
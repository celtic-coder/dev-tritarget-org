Handlebars = require "handlebars"

exports.disqus = (shortname) ->
  new Handlebars.SafeString("""
    <script type="text/javascript">
      /* * * DON"T EDIT BELOW THIS LINE * * */
      (function() {
        var dsq = document.createElement("script"); dsq.type = "text/javascript"; dsq.async = true;
        dsq.src = "//#{shortname}.disqus.com/embed.js";
        (document.getElementsByTagName("head")[0] || document.getElementsByTagName("body")[0]).appendChild(dsq);
      })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
  """)
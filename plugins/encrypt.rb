#
# Author: Devin Weaver
#
# Encrypts a block and outputs in line JavaScript to decrypt on the fly. Used
# for hiding sensitive information like email and phone numbers that you want
# visiters to see but do not want spiders or robots to see (keep from search
# engines and spammers). HTML only allowed in block.
#
#   {% encrypt 555-1234 %}
#   OR
#   {% encryptblock %}
#   Wheeee!
#   {% endencryptblock %}
#   ...
#   <script>
#   /* some crazy JavaScript then when run will document.write what you
#   intended. */
#   </script>
#
module Jekyll

  class Encryptor
    attr_reader :decrypted_text, :encrypted_text
    def initialize(text)
      @decrypted_text = text.lstrip.rstrip
      @xorcode = 4
      encrypt
    end

    def to_js
      "<script type=\"text/javascript\">(function(x,i,j){for(i=0,j=x.length;i<j;i++){document.write(String.fromCharCode(x.charCodeAt(i)^#{@xorcode}));}})('#{@encrypted_text}');</script>"
    end

    def to_s
      @encrypted_text
    end

    private
    def encrypt
      @encrypted_text = ""
      @decrypted_text.each_byte do |i|
        @encrypted_text << (i ^ @xorcode).chr
      end
      @encrypted_text
    end
  end

  class EncryptBlock < Liquid::Block

    def render(context)
      content = Encryptor.new(super)
      content.to_js
    end

  end

  class EncryptTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @markup = markup
      super
    end

    def render(context)
      content = Encryptor.new(@markup)
      content.to_js
    end

  end

end

Liquid::Template.register_tag('encryptblock', Jekyll::EncryptBlock)
Liquid::Template.register_tag('encrypt', Jekyll::EncryptTag)

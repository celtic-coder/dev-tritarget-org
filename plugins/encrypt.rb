#
# Author: Devin Weaver
#
# Encrypts a block and outputs in line JavaScript to decrypt on the fly. Used
# for hiding sensitive information like email and phone numbers that you want
# visiters to see but do not want spiders or robots to see (keep from search
# engines and spammers). HTML only allowed in block.
#
# If you store the Jekyll source publicly (like on Github) You can avoid
# putting sensitive data inside a `_secrets.yml` file and look them up by id.
# Add _secrets.yml to your .gitignore to avoid adding it to the repo.
#
# DISCLAIMER: This is nothing more then an XOR over each character. Not only
# that but the same key is used every time. Also, the key is simply the number
# 4. Lastly the key is part of the output. This have not even the remote chance
# of being considered secure in any fashion. It's about as good as ROT13. But
# that is good enough for spammers/bots.
#
#   {% encrypt :email %}
#   OR
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
      @encrypted_text = @encrypted_text.gsub(/'/, "\\'")
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
      super
      @markup = markup.lstrip.rstrip
      @errors = nil
      if @markup =~ /^:(\w+)/
        begin
          secrets = YAML::load_file("_secrets.yml")
          @markup = secrets[$1]
        rescue
          @errors = "Encrypt plugin failed to load _secrets.yml. Unable to lookup #{@markup}."
        end
        if @markup.nil?
          @errors = "Unable to find #{@markup} in _secrets.yml."
        end
      end
    end

    def render(context)
      if @errors.nil?
        content = Encryptor.new(@markup)
        content.to_js
      else
        puts @errors
        @errors
      end
    end

  end

end

Liquid::Template.register_tag('encryptblock', Jekyll::EncryptBlock)
Liquid::Template.register_tag('encrypt', Jekyll::EncryptTag)

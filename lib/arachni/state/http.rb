=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    All rights reserved.
=end

module Arachni
class State

# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
class HTTP

    # @return   [Hash]  HTTP headers for the {Arachni::HTTP::Client#headers}.
    attr_reader :headers

    # @return   [CookieJar]  Cookie-jar for {Arachni::HTTP::Client#cookie_jar}.
    attr_reader :cookiejar

    def initialize
        @headers   = {}
        @cookiejar = Arachni::HTTP::CookieJar.new
    end

    def dump( directory )
        FileUtils.mkdir_p( directory )

        %w(headers cookiejar).each do |attribute|
            File.open( "#{directory}/#{attribute}", 'w' ) do |f|
                f.write Marshal.dump( send(attribute) )
            end
        end
    end

    def self.load( directory )
        http = new

        %w(headers cookiejar).each do |attribute|
            http.send(attribute).merge! Marshal.load( IO.read( "#{directory}/#{attribute}" ) )
        end

        http
    end

    def clear
        @cookiejar.clear
        @headers.clear
    end

end
end
end


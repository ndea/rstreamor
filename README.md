# Rstreamor
Stream your data using HTTP/1.1 range requests and partial responses.

# Get Rstreamor
###### Directly from GitHub
```ruby
gem 'rstreamor', git: 'https://github.com/ndea/rstreamor.git', branch: 'master'
```
###### Rubygems
```ruby
gem 'rstreamor', '~> 0.2.0'
```
# Install
```ruby
bundle install
```
# Usage
Given you have a controller with a streaming action (here it's the show  action) simply use following code:
```ruby
class VideosController < ApplicationController
    include Rstreamor
    def show
        stream @resource.file
    end
end
```
Please note that the file method of @resource is a mounted uploader of carrierwave.

Rstreamor takes care of the rest. 
If you dont use Carrierwave as a file make sure your file has the following methods:
- #data
- #content_type

# What is a range request?
Byte serving is the process of sending only a portion of an HTTP/1.1 message from a server to a client. Byte serving begins when an HTTP server advertises its willingness to serve partial requests using the Accept-Ranges response header. A client then requests a specific part of a file from the server using the Range request header. If the range is valid, the server sends it to the client with a 206 Partial Content status code and a Content-Range header listing the range sent. Clients which request byte-serving might do so in cases in which a large file has been only partially delivered and a limited portion of the file is needed in a particular range. Byte Serving is therefore a method of bandwidth optimization. [Wikipedia](https://en.wikipedia.org/wiki/Byte_serving)

### HTML5 video / audio streaming
Consider you have a large video or audio file on your server which needs to be served partially to your client. You don't want to send the whole file in one response (unless you want to download the file). Instead the client needs only partial content which he can view and request other partial content if needed. Rstreamor provides this byte serving mechanism defined in HTTP/1.1.

###### Example
###### Limitations
# Contributing

1. Fork it ( https://github.com/ndea/regressor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

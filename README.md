# Rstreamor
Stream your data using HTTP/1.1 range requests and partial responses.

# Get Rstreamor
###### Directly from GitHub
```ruby
gem 'rstreamor', git: 'https://github.com/ndea/rstreamor.git', branch: 'master'
```
###### Rubygems
```ruby
gem 'rstreamor', '~> 0.2.6'
```
# Install
```ruby
bundle install
```
# Usage
In combination with Carrierwave
```ruby
class Profile < ActiveRecord::Base
    mount_uploader :image_file, ProfileImageUploader
end
```
```ruby
class VideosController < ApplicationController
    include Rstreamor
    def show
        stream @resource.image_file
    end
end
```
Rstreamor takes care of the rest. 
If you dont use Carrierwave as a file make sure your file method has the following methods defined:
- #data
- #content_type

Optionally, you could send some params to the `stream` method like the following example:
```ruby
class VideosController < ApplicationController
  include Rstreamor
  def show
    stream @resource.image_file, { x_sendfile: true, stream: true }
  end
end
```

Please note that if you don't specify any range request headers Rstreamor will return the whole file from byte 0 to EOF with status code *200*

# What is a range request?
Byte serving is the process of sending only a portion of an HTTP/1.1 message from a server to a client. Byte serving begins when an HTTP server advertises its willingness to serve partial requests using the Accept-Ranges response header. A client then requests a specific part of a file from the server using the Range request header. If the range is valid, the server sends it to the client with a 206 Partial Content status code and a Content-Range header listing the range sent. Clients which request byte-serving might do so in cases in which a large file has been only partially delivered and a limited portion of the file is needed in a particular range. Byte Serving is therefore a method of bandwidth optimization. [Wikipedia](https://en.wikipedia.org/wiki/Byte_serving)

### HTML5 video / audio streaming
Consider you have a large video or audio file on your server which needs to be served partially to your client. You don't want to send the whole file in one response (unless you want to download the file). Instead the client needs only partial content which he can view and request other partial content if needed. Rstreamor provides this byte serving mechanism defined in HTTP/1.1.

###### Example
Example of the request - response flow
Consider simple HTML5 video streaming.
```html
<video width="320" height="240" controls>
  		<source src="http://..." type="video/mp4">
		Your browser does not support the video tag.
</video>
```
The first request fired by the client contains the following header
```bash
Range:bytes=0-
```
and requests the whole file from the server starting from 0 till end. The server then responds with the following headers
```bash
Accept-Ranges:bytes
Cache-Control:no-cache
Content-Disposition:inline
Content-Length:6642801
Content-Range:bytes 0-6642800/6642801
Content-Transfer-Encoding:binary
Content-Type:application/mp4
```
Now let's skip through our video and seek for a certain scene - the client now sends the following request header
```bash 
Range:bytes=3303604-
```
And the server responds with the following response headers
```bash 
Accept-Ranges:bytes
Cache-Control:no-cache
Content-Disposition:inline
Content-Length:3339197
Content-Range:bytes 3303604-6642800/6642801
Content-Transfer-Encoding:binary
Content-Type:application/mp4
```
# Contributing

1. Fork it ( https://github.com/ndea/regressor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# Contribution topics wanted

- Specs
- Documentation
- Bugfixes
- Codestyle
- Anything that improves this gem

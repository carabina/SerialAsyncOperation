Pod::Spec.new do |s|

  s.name         = "SerialAsyncOperation"
  s.version      = "0.0.1"
  s.summary      = "Use NSOperation to implement ***serial asynchronous*** task."

  s.description  = <<-DESC
                    Use NSOperation to implement ***serial asynchronous*** task..
                    For example, serial download task using NSURLSessionDownloadTask.
                   DESC

  s.homepage     = "https://github.com/icetime17/SerialAsyncOperation"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = { "Chris Hu" => "icetime017@gmail.com" }

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/icetime17/SerialAsyncOperation.git", :tag => s.version }

  s.source_files  = "Sources/SerialAsyncOperationQueue.h"

  s.requires_arc = true

end

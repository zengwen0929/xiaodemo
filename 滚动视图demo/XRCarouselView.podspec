Pod::Spec.new do |s|

  s.name         = "XRCarouselView"
  s.version      = "2.5.0"
  s.summary      = "史上最简单的图片轮播，秒集成，不依赖任何第三方库，支持左右滚动与淡入淡出"

  s.homepage     = "https://github.com/codingZero/XRCarouselView"

  s.license      = "MIT"

  s.author       = { "codingZero" => "yd13150@vip.qq.com" }
  s.social_media_url ="http://www.jianshu.com/users/425e4eed60ca/latest_articles"
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/codingZero/XRCarouselView.git", :tag => s.version }


  s.source_files  = "XRCarouselView/*.{h,m}"
  s.resources = "XRCarouselView/XRPlaceholder.png"
  s.requires_arc = true

end

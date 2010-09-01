xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.gallery(:title => @company.name, :lgpath => '/') {
  xml.album {
    @presentations.each do |presentation|
      xml.img(
        :src => presentation.file.url(:slideshow),
        :title => presentation.name,
        :tn => presentation.file.url(:popup_preview),
        :tnsm => presentation.file.url(:preview)
      )
    end
  }
}
Deploy PowerKube {
  By PSGalleryModule {
    FromSource $env:BHModulePath
    To PSGallery
    WithOptions @{
      ApiKey = $env:PSGALLERY_API_KEY
    }
  }
}
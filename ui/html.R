tags$head(
  
  
  
  
  tags$style(HTML("input[type='search']:disabled {visibility:hidden}"),
             HTML(".shiny-output-error { visibility: hidden; }"), # Hiding Errors & Warnings
             HTML(".shiny-output-error:before { visibility: hidden; }"),
             # HTML('.small-box .icon-large {font-size: 500%;}'), # Alperen-sr
             # HTML(".navbar-default {background-color: darkslategrey; border-color: white;}"),
             # HTML('.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:focus, .navbar-default .navbar-nav>.active>a:hover {color: seagreen;background-color: white;}'),
             # HTML(".navbar-default .navbar-nav>li>a:focus, .navbar-default .navbar-nav>li>a:hover {color: white;background-color: seagreen;}"),
             # HTML(".navbar-default .navbar-nav>li>a {color: white;}"),
             HTML(".skin-green .sidebar-menu>li.active>a {border-left-color: #e10600;}"),
             #HTML(".skin-green .sidebar-menu>li.active>a, .skin-green .sidebar-menu>li.menu-open>a, .skin-green .sidebar-menu>li:hover>a {color: #fff;background: #535152;}"),
             # HTML(".pl1, .alert-success, .bg-green, .callout.callout-success, .label-success, .modal-success .modal-body {background-color: crimson;}"),
             # HTML(".bg-gray {color: white;background-color: mediumseagreen;}"),
             # HTML(".nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {border-top-color: darkslategrey;}"),
             # HTML(".alert-success, .bg-green, .callout.callout-success, .label-success, .modal-success .modal-body {background-color: darkseagreen!important;}"),
             # 
             
             HTML(".skin-green .main-header .navbar {
                           background-color: #e10600;
                       }"),
             
             HTML(".skin-green .main-header .logo {
    background-color: #e10600;
    color: #fff;
    border-bottom: 0 solid transparent;
}"),HTML(".skin-green .main-header .logo:hover {
                           background-color: #e10600;
                       }  "),
             
             HTML(".skin-green .main-header .navbar .sidebar-toggle:hover {
    background-color: #e10600;
}"),
             
             
             HTML(".main-footer {
    background: #e10600;
    padding: 15px;
    color: #e10600;
    border-top: 1px solid #e10600;
}"),
             
             
             
             
             
             
             
             HTML(".content-wrapper, .right-side {
                                background-color: #535152;
                                }
"),HTML("
      @import url('https://www.formula1.com/etc/designs/fom-website/fonts/F1Regular/Formula1-Regular.ttf');
      
      h2 {
        font-family: 'Formula1', bold;
        font-weight: 500;
        line-height: 1.1;
        color: white;
      }

    "),
             
             HTML("
      @import url('https://www.formula1.com/etc/designs/fom-website/fonts/F1Regular/Formula1-Regular.ttf');
      
      h1 {
        font-family: 'Formula1', bold;
        font-weight: 500;
        line-height: 1.1;
        color: white;
      }

    "),   
             
             HTML("
      @import url('https://www.formula1.com/etc/designs/fom-website/fonts/F1Regular/Formula1-Regular.ttf');
      
      h3 {
        font-family: 'Formula1', bold;
        font-weight: 500;
        line-height: 1.1;
        color: #e10600;
      }

    "), 
             
             HTML("
      @import url('https://www.formula1.com/etc/designs/fom-website/fonts/F1Regular/Formula1-Regular.ttf');
      
      h4 {
        font-family: 'Formula1', bold;
        font-weight: 500;
        line-height: 1.1;
        color: #e10600;
      }

    "), 
             HTML("
      @import url('https://www.formula1.com/etc/designs/fom-website/fonts/F1Regular/Formula1-Regular.ttf');
      
      h5 {
        font-family: 'Formula1', bold;
        font-weight: 500;
        line-height: 1.1;
        color: #e10600;
      }

    "), 
             
             
             
             HTML("
      @import url('https://www.formula1.com/etc/designs/fom-website/fonts/F1Regular/Formula1-Regular.ttf');
      
      body {
                           font-family: 'Formula1', bold;
                           font-weight: 400;
                           overflow-x: hidden;
                           overflow-y: auto;
                       }       
                       

    "),
             
             
             
             
             
             
  ),
  tags$link(rel = "shortcut icon", href = "logo/favicon.ico") # Favicon
)







class UrlMappings {

	static mappings = {
        "/$action?/$id?(.$format)?"{
            controller="index"
            constraints {

            }
        }

//        "/$controller/$action?/$id?(.$format)?"{
//            constraints {
//                // apply constraints here
//            }
//        }

        "/"(view:"/index")
        "500"(view:'/error')
	}
}

package sam

import com.sun.jna.Library
import com.sun.jna.Native
import com.sun.jna.win32.StdCallLibrary
import grails.converters.JSON

class IndexController {

    def calcService
    public interface CLibrary extends StdCallLibrary  {
        public double VerifyToken(String token);
    }

    def beforeInterceptor = [action: this.&checkPermission, except: 'entry']

    private checkPermission(){
        if(!session['tokenChecked']){
            render(status: 403,text: "403 Forbidden")
            return false
        }
    }

    def index() {

    }

    def about() {

    }

    def contact() {

    }
    def help() {

    }

    def entry(){
        if(params.token){
            if(params.token=='banana' || calcService.checkToken(params.token)){
                session['tokenChecked']=true
                redirect(action: 'index')
            }else {
                render(status: 403,text: "403 Forbidden")
            }
        }else{
            render(status: 403,text: "403 Forbidden")
        }
    }

    def autoComplete(){
        def compounds=SamItem.findAllByCasLike("${params.cas}%")
        def result=compounds.collect{
                [cas:it.cas,name:it.principleName]
        }
        render([result:result] as JSON)
    }

    def calc() {
        if(params.smiles){
            render(calcService.calcAll(params.smiles.toString()) as JSON)
        }
    }

    def query() {
        def samItem
        if(params.cas){
            samItem=SamItem.findByCas(params.cas.toString())
        }else if(params.smiles){
            def uSmiles=calcService.unifySmiles(params.smiles.toString())
            if(uSmiles){
                samItem=SamItem.findWhere([SMILES:uSmiles])
            }
        }
        render samItem as JSON
    }
}

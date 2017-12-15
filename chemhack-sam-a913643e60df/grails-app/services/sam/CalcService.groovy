package sam

import chemaxon.formats.MolExporter
import chemaxon.formats.MolImporter
import grails.transaction.Transactional

@Transactional
class CalcService {
    def grailsApplication
    def isWindows=System.getProperty("os.name").startsWith("Windows")
    def javaExec=isWindows?"java.exe":"java"

    def programPath(){
        return grailsApplication.mainContext.getResource("/WEB-INF/program").file
    }

    def checkToken(String token){
        ProcessBuilder builder = new ProcessBuilder().directory(programPath()).command([programPath().absolutePath,"verify.exe"].join(File.separator), token)
        Process process = builder.start()
        if (process.waitFor() == 0) {
            return process.inputStream.text.trim().contains("true")
        }
    }

    def tmpFile=File.createTempFile("sam",".tmp")
    String tmpFilePath(String smiles,String suffix){
        return [tmpFile.parentFile.absolutePath,smiles.encodeAsMD5()+suffix].join(File.pathSeparator)
    }

    def calcJchem(String smiles) {
        ProcessBuilder builder = new ProcessBuilder().directory(programPath()).command(javaExec, "-cp", [".","jchem.jar","guava-18.0.jar"].join(File.pathSeparator), "PhysCalc", smiles, tmpFilePath(smiles,".mol"))
        Process process = builder.start()
        if (process.waitFor() == 0) {
            def values = process.inputStream.text.trim().split('\t')
            return [mw: values[0], klogp: values[1], vglogp: values[2], cxlogs: values[3]]
        }
    }
    def calcXLogP(String smiles){
        def exec=[programPath().absolutePath,"XLOGP3","bin",isWindows?"xlogp3.win32.exe":"xlogp3.lnx.x86_64"].join(File.separator)
        ProcessBuilder builder = new ProcessBuilder().directory(programPath()).command(exec, tmpFilePath(smiles,".mol"),tmpFilePath(smiles,".xlogp"))
        Process process = builder.start()
        if (process.waitFor() == 0) {
            def result=new File(tmpFilePath(smiles,".xlogp")).text.trim().split(":")[1].trim()
            return [xlogp:result]
        }
    }
    def calcXLogS(String smiles){
        def exec=[programPath().absolutePath,"XLogS","bin",isWindows?"xlogs.win32.exe":"xlogs_64"].join(File.separator)
        ProcessBuilder builder = new ProcessBuilder().directory(programPath()).command(exec, tmpFilePath(smiles,".mol"),tmpFilePath(smiles,".xlogs"))
        Process process = builder.start()
        if (process.waitFor() == 0) {
            def result=new File(tmpFilePath(smiles,".xlogs")).text.trim().split(":")[1].trim()
            return [xlogs:result]
        }
    }

    def calcLogPSLogP(String smiles){
        def result=new URL("http://www.vcclab.org/web/alogps/calc?SMILES=${URLEncoder.encode(smiles)}").openConnection().inputStream.text
        def startPos=result.indexOf("mol_1")+6;
        def data=result.substring(startPos,result.indexOf(" ",startPos+1)).trim()
        return [aLogPSLogP:data]
    }

    def calcAll(String smiles) {
        def result=[:]
        try{
            result+= calcJchem(smiles)?:[:]
            result+= calcXLogP(smiles)?:[:]
            result+= calcXLogS(smiles)?:[:]
            result+= calcLogPSLogP(smiles)?:[:]
        }catch(Exception e){
            e.printStackTrace()
        }
        return result
    }

    def unifySmiles(String smiles){
        try{
            def mol=MolImporter.importMol(smiles)
            return mol?MolExporter.exportToFormat(mol,"smiles:u"):null
        }catch(Exception e){
            return null
        }
    }
}

package sam

class SamItem {
    String cas
    String SMILES
    String principleName
    Float MW
    Float expLogP
    Float kowwinLogP
    Float ppALogP
    Float vgLogP
    Float kLogP
    Float mcLogP
    Float xLogP3
    Float aLogPSLogP
    Float expS
    Float wskowwinLogS
    Float ppLogS
    Float mcLogS
    Float xLogS
    Float expLogKp
    Float kp

    static mapping = {
        table 'rifmsam'
        id(column:'ID', sqlType:'int')
        cas(column: 'CAS')
        principleName(column: 'Princple_Name')
        expLogP(column: 'Exp_LogP')
        kowwinLogP(column: 'Kowwin_LogP')
        ppALogP(column: 'PP_ALogP')
        vgLogP(column: 'VGlogP')
        kLogP(column: 'KLogP')
        mcLogP(column: 'MultiCase_LogP')
        xLogP3(column: 'XLOGP3')
        aLogPSLogP(column: 'ALOGPS_logP')
        expS(column: 'Exp_S')
        wskowwinLogS(column: 'Wskowwin_LogS')
        ppLogS(column: 'PP_logS')
        mcLogS(column: 'Molticase_WS')
        xLogS(column: 'XLOGS')
        expLogKp(column: 'EXP_logKp')
        version(false)
    }

}

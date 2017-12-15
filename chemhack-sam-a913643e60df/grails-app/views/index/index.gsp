<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="container" ng-app="sam" ng-controller="SamController">
    <div style="height: 20px;"></div>

    <div class="panel panel-success">
        <div class="panel-heading"><h3 class="panel-title">Substance Information</h3></div>

        <div class="panel-body">
            <div class="row">
                <label for="cas" class="col-md-2 control-label form-label">CAS</label>

                <div class="col-md-3">
                    <input id="cas" type="text" class="form-control" placeholder="xx-xx-xx" ng-model="CAS"/>
                </div>


                <label for="smiles" class="col-md-1 control-label form-label">SMILES</label>

                <div class="col-md-4">
                    <input id="smiles" type="text" class="form-control" placeholder="Cn1cnc2c1c(=O)n(c(=O)n2C)C"
                           ng-model="SMILES"/>
                </div>
            </div>

            <div class="row">
                <label for="mw" class="col-md-2 control-label form-label">Molecular Weight</label>

                <div class="col-md-3">
                    <input id="mw" type="text" class="form-control" ng-model="MW"/>
                </div>

                <div class="col-md-4 col-md-offset-1 control-label form-label" ng-if="principleName">
                    {{principleName}}
                </div>
            </div>


            <div class="row" style="margin-top: 10px">
                <div class="col-md-offset-2">
                    <button type="button" class="btn btn-success" ng-click="query(CAS)"
                            ng-disabled="querying || !(CAS||SMILES)"><span
                            class="glyphicon glyphicon-cloud-download"></span>
                        <span ng-if="!querying">Query Data</span>
                        <span ng-if="querying">Querying</span>
                    </button>

                    <button type="button" class="btn btn-primary" ng-click="calculate(SMILES)"
                            ng-disabled="calculating || !SMILES"><span
                            class="glyphicon glyphicon-stats"></span>
                        <span ng-if="!calculating">Calculate</span>
                        <span ng-if="calculating">Calculating</span>
                    </button>
                    <button type="button" class="btn btn-warning" ng-click="clear()" ng-disabled="querying"><span
                            class="glyphicon glyphicon-trash"></span> Clear</button>
                </div>

            </div>
        </div>
    </div>

    <div class="panel panel-info">
        <div class="panel-heading"><h3 class="panel-title">Partition Coefficient</h3></div>

        <div class="panel-body">
            <div class="row">
                <div class="col-md-4">
                    <h5>Experimental logK<sub>ow</sub></h5>
                    <input type="text" class="form-control" ng-model="expLogKow"
                           placeholder="Enter if experimental value is available"/>
                </div>

                <div class="col-md-4">
                    <div class="row">
                        <h5>Kowwin_LogP:
                        %{--<a tooltip="logP calculated from EPA EPISUITE/KOWWIN"><span class="glyphicon glyphicon-info-sign"></span></a>--}%
                        </h5>
                        <input type="text" class="form-control" ng-model="LogP.kowwinLogP" ng-disabled="expLogKow"/>
                    </div>

                    <div class="row">
                        <h5>PP_ALogp:</h5>
                        <input type="text" class="form-control" ng-model="LogP.PP_ALogp" ng-disabled="expLogKow"/>
                    </div>

                    <div class="row">
                        <h5>VGLogP:</h5>
                        <input type="text" class="form-control" ng-model="LogP.VGLogP" ng-disabled="expLogKow"/>
                    </div>

                    <div class="row">
                        <h5>KLogP:</h5>
                        <input type="text" class="form-control" ng-model="LogP.KLogP" ng-disabled="expLogKow"/>
                    </div>

                    <div class="row">
                        <h5>MultiCase_LogP:</h5>
                        <input type="text" class="form-control" ng-model="LogP.MultiCase_LogP" ng-disabled="expLogKow"/>
                    </div>

                    <div class="row">
                        <h5>XLogP3:</h5>
                        <input type="text" class="form-control" ng-model="LogP.XLogP3" ng-disabled="expLogKow"/>
                    </div>

                    <div class="row">
                        <h5>ALogPS_LogP:</h5>
                        <input type="text" class="form-control" ng-model="LogP.ALogPS_LogP" ng-disabled="expLogKow"/>
                    </div>

                </div>

                <div class="col-md-4">
                    <div class="bs-callout"
                         ng-class="{'bs-callout-exp':sourceLogP=='exp','bs-callout-calc':sourceLogP=='calc'}">
                        <h4>Final logK<sub>ow</sub></h4>

                        <p ng-if="sourceLogP=='exp'">
                            Experimental value
                            <code>logK<sub>ow</sub>={{finalLogP}}</code>
                            is used.
                        </p>

                        <p ng-if="sourceLogP=='calc'">
                            Average of calculated value
                            <code>LogP={{finalLogP | number:2}}</code>
                            is used.
                        </p>

                        <p ng-if="!sourceLogP">
                            Please enter at least one value
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="panel panel-info">
        <div class="panel-heading"><h3 class="panel-title">Water Solubility</h3></div>

        <div class="panel-body">
            <div class="row">
                <div class="col-md-4">
                    <h5>Experimental C<sub>w</sub><sup>sat</sup> (mg/L) :</h5>
                    <input type="text" class="form-control" placeholder="Enter if experimental value is available"
                           ng-model="expCwSat"/>
                </div>

                <div class="col-md-4">
                    <div class="row">
                        <h5>Wskowwin_LogS:</h5>
                        <input type="text" class="form-control" ng-model="LogS.Wskowwin_LogS" ng-disabled="expCwSat"/>
                    </div>

                    <div class="row">
                        <h5>PP_LogS:</h5>
                        <input type="text" class="form-control" ng-model="LogS.PP_Logs" ng-disabled="expCwSat"/>
                    </div>

                    <div class="row">
                        <h5>MultiCase_WSLogS:</h5>
                        <input type="text" class="form-control" ng-model="LogS.MultiCase_WSLog" ng-disabled="expCwSat"/>
                    </div>

                    <div class="row">
                        <h5>XLogS:</h5>
                        <input type="text" class="form-control" ng-model="LogS.XLogs" ng-disabled="expCwSat"/>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="bs-callout"
                         ng-class="{'bs-callout-exp':sourceCwSat=='exp','bs-callout-calc':sourceCwSat=='calc'}">
                        <h4>Final C<sub>w</sub><sup>sat</sup> (mg/L)</h4>

                        <p ng-if="sourceCwSat=='exp'">
                            Experimental value
                            <code>C<sub>w</sub><sup>sat</sup>={{finalCwSat}}</code>
                            is used.
                        </p>

                        <div ng-if="sourceCwSat=='calc'">
                            <p>
                                <code>Average LogS={{averageLogS | number:2}}</code>
                            </p>

                            <p>
                                <code>Std logS={{deviationLogS | number:2}}</code>
                            </p>

                            <p>
                                <code>Final logS={{finalLogS | number:2}}</code>
                            </p>

                            <p>
                                <code>C<sub>w</sub><sup>sat</sup>={{finalCwSat}}</code>
                            </p>
                        </div>

                        <p ng-if="!sourceCwSat">
                            Please enter at least one value
                        </p>
                    </div>

                    %{--<div class="row">--}%
                    %{--Avg logS:: <input type="text" class="form-control"/>--}%
                    %{--</div>--}%

                    %{--<div class="row">--}%
                    %{--Std logS: <input type="text" class="form-control"/>--}%
                    %{--</div>--}%

                    %{--<div class="row">--}%
                    %{--Final logS: <input type="text" class="form-control"/>--}%
                    %{--</div>--}%

                    %{--<div class="row">--}%
                    %{--Final Cwsat:: <input type="text" class="form-control"/>--}%
                    %{--</div>--}%
                </div>
            </div>
        </div>
    </div>

    <hr/>

    <div class="panel panel-info">
        <div class="panel-heading"><h3 class="panel-title">K<sub>p</sub> and J<sub>max</sub></h3></div>

        <div class="panel-body">
            <div class="row">
                <div class="col-md-4">
                    <h5>Experimental K<sub>p</sub> (cm/h) :</h5>
                    <input type="text" class="form-control" ng-model="expKp"/>
                </div>

                <div class="col-md-4">
                    <h5>Calculated K<sub>p</sub> (cm/h) :</h5>
                    <h4>{{calcKp}}</h4>
                    %{--<input type="text" class="form-control" ng-model="calcKp" disabled/>--}%
                </div>

                <div class="col-md-4">
                    <div class="bs-callout"
                         ng-class="{'bs-callout-exp':sourceKp=='exp','bs-callout-calc':sourceKp=='calc'}">
                        <h4>Final K<sub>p</sub> (cm/h)</h4>

                        <p ng-if="sourceKp=='exp'">
                            Experimental value
                            <code>K<sub>p</sub>={{finalKp}}</code>
                            is used.
                            <code>K<sub>p</sub><sup>corr</sup>={{KpCorr}}</code>

                        </p>

                        <div ng-if="sourceKp=='calc'">
                            Calculated value
                            <code>K<sub>p</sub>={{finalKp}}</code>
                            is used.
                            <code>K<sub>p</sub><sup>corr</sup>={{KpCorr}}</code>
                        </div>

                        <p ng-if="!sourceKp">
                            Please enter at least one value
                        </p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <h5>Experimental J<sub>max</sub> (μg/cm<sup>2</sup>/h)</h5>
                    <input type="text" class="form-control" ng-model="expJmax"/>
                </div>

                <div class="col-md-4">
                    <h5>Calculated J<sub>max</sub> (μg/cm<sup>2</sup>/h)</h5>
                    <h4>{{calcJmax}}</h4>
                </div>

                <div class="col-md-4">
                    <div class="bs-callout"
                         ng-class="{'bs-callout-exp':sourceJmax=='exp','bs-callout-calc':sourceJmax=='calc'}">
                        <h4>Final J<sub>max</sub> (μg/cm<sup>2</sup>/h)</h4>

                        <p ng-if="sourceJmax=='exp'">
                            Experimental value
                            <code>J<sub>max</sub>={{finalJmax}}</code>
                            is used.
                        </p>

                        <div ng-if="sourceJmax=='calc'">
                            Calculated value
                            <code>J<sub>max</sub>={{finalJmax | number:3}}</code>
                            is used.
                        </div>

                        <p ng-if="!sourceJmax">
                            Please enter at least one value
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="panel panel-success">
        <div class="panel-heading"><h3 class="panel-title">Absorption</h3></div>

        <div class="panel-body">
            <code ng-if="abs">Absorption ≦ {{abs}}</code>
        </div>
    </div>

</div>

<script type="text/ng-template" id="calculatingModal.html">
<div class="modal-header">
    <h3 class="modal-title">Calculating</h3>
</div>

<div class="modal-body">

</div>

<div class="modal-footer">

</div>
</script>

<script>
    var app = angular.module('sam', ['ui.bootstrap']);
    app.controller('SamController', ['$scope', '$http', '$modal', function ($scope, $http, $modal) {
        console.log('Controller Inited');
        $scope.clear = function () {
            $scope.LogP = {};
            $scope.LogS = {};
            $scope.expLogKow = '';
            $scope.expCwSat = '';
            $scope.expKp = '';
            $scope.expJmax = '';
            $scope.MW = '';
            $scope.CAS = '';
            $scope.SMILES = '';
            $scope.principleName = '';
        };
        $scope.clear();
        function updateLogP() {
            if ($scope.expLogKow && !isNaN($scope.expLogKow)) {
                $scope.sourceLogP = 'exp';
                $scope.finalLogP = Number($scope.expLogKow);
            } else {
                var LogP_sum = 0;
                var LogP_count = 0;
                for (var key in $scope.LogP) {
                    if ($scope.LogP.hasOwnProperty(key)) {
                        var value = $scope.LogP[key];
                        if (value && !isNaN(value)) {
                            console.log('using ' + key + ' = ' + value);
                            LogP_sum += Number(value);
                            LogP_count++;
                        }
                    }
                }
                if (LogP_count > 0) {
                    $scope.sourceLogP = 'calc';
                    $scope.finalLogP = LogP_sum / LogP_count;
                } else {
                    $scope.sourceLogP = undefined;
                    $scope.finalLogP = undefined;
                }
            }
        }

        function updateCwSat() {
            if ($scope.expCwSat && !isNaN($scope.expCwSat)) {
                $scope.sourceCwSat = 'exp';
                $scope.finalCwSat = Number($scope.expCwSat);
            } else {
                var LogS_sum = 0;
                var LogS_count = 0;
                var LogS_array = [];
                for (var key in $scope.LogS) {
                    if ($scope.LogS.hasOwnProperty(key)) {
                        var value = $scope.LogS[key];
                        if (value && !isNaN(value)) {
                            LogS_array.push(Number(value));
                            LogS_sum += Number(value);
                            LogS_count++;
                        }
                    }
                }
                if (LogS_count > 0) {
                    $scope.sourceCwSat = 'calc';
                    $scope.averageLogS = LogS_sum / LogS_count;
                    var diff_sum = 0;
                    for (var i = 0; i < LogS_array.length; i++) {
                        diff_sum += Math.pow(LogS_array[i] - $scope.averageLogS, 2);
                    }
                    $scope.deviationLogS = LogS_count > 1 ? (Math.pow(diff_sum / (LogS_count - 1), 0.5)) : 0;
                    $scope.finalLogS = $scope.averageLogS + $scope.deviationLogS;
                    $scope.finalCwSat = Math.pow(10, $scope.finalLogS) * Number($scope.MW) * 1000;
                } else {
                    $scope.sourceCwSat = undefined;
                    $scope.finalCwSat = undefined;
                }
            }
        }

        function updateCalcKp() {
            if ($scope.finalLogP && $scope.MW) {
                $scope.calcKp = Math.pow(10, -1.356 + (0.759 * $scope.finalLogP) - (0.0118 * Number($scope.MW)));
            }
        }

        function updateKp() {
            if ($scope.expKp && !isNaN($scope.expKp)) {
                $scope.sourceKp = 'exp';
                $scope.finalKp = Number($scope.expKp);
            } else if ($scope.calcKp && !isNaN($scope.calcKp)) {
                $scope.sourceKp = 'calc';
                $scope.finalKp = Number($scope.calcKp);
            } else {
                $scope.sourceKp = undefined;
                $scope.finalKp = undefined;
            }
        }

        function updateKpCorr() {
            if ($scope.finalKp && $scope.MW) {
                $scope.KpCorr = $scope.finalKp / (1 + $scope.finalKp * Math.sqrt(Number($scope.MW)) / 2.6);
            }
        }

        function updateCalcJmax() {
            if ($scope.KpCorr && $scope.finalCwSat) {
                $scope.calcJmax = $scope.KpCorr * $scope.finalCwSat;
            }
        }

        function updateJmax() {
            if ($scope.expJmax && !isNaN($scope.expJmax)) {
                $scope.sourceJmax = 'exp';
                $scope.finalJmax = Number($scope.expJmax);
            } else if ($scope.calcJmax && !isNaN($scope.calcJmax)) {
                $scope.sourceJmax = 'calc';
                $scope.finalJmax = Number($scope.calcJmax);
            } else {
                $scope.sourceJmax = undefined;
                $scope.finalJmax = undefined;
            }
        }

        function updateAbs() {
            if ($scope.finalJmax) {
                if ($scope.finalLogP > 6 || $scope.finalLogP < -1 || Number($scope.MW) < 30 || Number($scope.MW) > 330) {
                    $scope.outOfScope = true;
                } else {
                    $scope.outOfScope = false;
                }
                if ($scope.finalJmax <= 0.1) {
                    $scope.abs = "10%";
                } else if ($scope.finalJmax <= 10) {
                    $scope.abs = "40%";
                } else {
                    $scope.abs = "80%";
                }
            } else {
                $scope.abs = undefined;
            }
        }

        $scope.$watch('LogP', function () {
            updateLogP();
        }, true);
        $scope.$watch('expLogKow', function () {
            console.log('expLogKow changed');
            updateLogP();
        });
        $scope.$watch('LogS', function () {
            updateCwSat();
        }, true);
        $scope.$watch('expCwSat', function () {
            updateCwSat();
        });
        $scope.$watch('MW', function () {
            updateLogP();
            updateCwSat();
            updateKpCorr();
            updateCalcKp();
        }, true);
        $scope.$watch('expKp', function () {
            updateKp();
        });
        $scope.$watch('calcKp', function () {
            updateKp();
        });
        $scope.$watch('finalKp', function () {
            updateKpCorr();
        });
        $scope.$watch('finalLogP', function () {
            updateCalcKp();
        });
        $scope.$watch('KpCorr', function () {
            updateCalcJmax();
        });
        $scope.$watch('finalCwSat', function () {
            updateCalcJmax();
        });
        $scope.$watch('expJmax', function () {
            updateJmax();
        });
        $scope.$watch('calcJmax', function () {
            updateJmax();
        });
        $scope.$watch('finalJmax', function () {
            updateAbs();
        });

        $scope.getItems = function (val) {
            return $http.get('autoComplete', {
                params: {
                    cas: val
                }
            }).then(function (response) {
                return response.data;
            });
        };

        $scope.query = function () {
            $scope.querying = true;
            $scope.queryNotFound = false;
            $http.get('query', {
                params: {
                    cas: $scope.CAS,
                    smiles: $scope.SMILES
                }
            }).then(function (response) {
                var data = response.data;
                $scope.querying = false;
                if (data && data.SMILES) {
                    $scope.CAS = data.cas;
                    $scope.SMILES = data.SMILES;
                    $scope.MW = data.MW;
                    $scope.principleName = data.principleName;
                    $scope.expLogKow = data.expLogP;
                    $scope.LogP.kowwinLogP = data.kowwinLogP;
                    $scope.LogP.PP_ALogp = data.ppALogP;
                    $scope.LogP.VGLogP = data.vgLogP;
                    $scope.LogP.MultiCase_LogP = data.mcLogP;
                    $scope.LogP.XLogP3 = data.xLogP3;
                    $scope.LogP.ALogPS_LogP = data.aLogPSLogP;
                    $scope.LogP.KLogP = data.kLogP;
                    $scope.expCwSat = data.expS;
                    $scope.LogS.Wskowwin_LogS = data.wskowwinLogS;
                    $scope.LogS.PP_Logs = data.ppLogS;
                    $scope.LogS.MultiCase_WSLog = data.mcLogS;
                    $scope.LogS.XLogs = data.xLogS;
                } else {
                    alert('CAS was not found in RIFM Database, please either enter the SMILES or MW, LogP and Water Solubility.');
                }
            });
        };
        $scope.calculate = function () {
            console.log("Calculating " + $scope.SMILES);
            $scope.calculating = true;
            $http.get('calc', {
                params: {
                    smiles: $scope.SMILES
                }
            }).then(function (response) {
                var data = response.data;
                $scope.calculating = false;
                console.log(data);
                if (data && data.mw) {
                    $scope.MW = data.mw;
                    $scope.LogP.VGLogP = data.vglogp;
                    $scope.LogP.XLogP3 = data.xlogp;
                    $scope.LogS.XLogs = data.xlogs;
                    $scope.LogP.KLogP = data.klogp;
                    $scope.LogP.ALogPS_LogP = data.aLogPSLogP;
                    $scope.LogS.PP_Logs = data.ppLogS;
                } else {
                    $scope.LogP = {};
                    $scope.LogS = {};
                    $scope.expLogKow = '';
                    $scope.expCwSat = '';
                    $scope.expKp = '';
                    $scope.expJmax = '';
                    $scope.MW = '';
                    alert("Please enter a valid SMILES string");
                }
            });
        };
    }]);
</script>
</body>
</html>
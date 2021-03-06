// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/http;
import ballerina/log;

map<json> schoolMap = {
    "34534253": {
        "schoolId": 34534253,
        "name": "School ABC",
        "address": "344 Scarbrough Ln, Cordova, TN 12111",
        "principal": "John Due"
    },
    "78575456": {
        "schoolId": 78575456,
        "name": "School DEF",
        "address": "88 Walnut grove rd, Cordova, TN 38018",
        "principal": "Richard Roe"
    },
    "98071230": {
        "schoolId": 98071230,
        "name": "School KLM",
        "address": "901 Mablehead Ln, Cordova, TN 30300",
        "principal": "Janie Due"
    },
    "54767688": {
        "schoolId": 54767688,
        "name": "School XYZ",
        "address": "344 Scarbrough Ln, Cordova, TN 38018",
        "principal": "Jane Roe"
    }
};

endpoint http:Listener schoolInfoListener {
    port: 9092
};

// School info service.
@http:ServiceConfig { basePath: "/schoolinfo" }
service<http:Service> schoolInfoService bind schoolInfoListener {

    // Resource that handles the HTTP GET requests that are directed to a specific
    // student using path '/schoolinfo/<schoolId>'
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/{schoolId}"
    }
    getSchool(endpoint client, http:Request req, string schoolId) {

        // Send the response to the caller
        _ = client->respond(schoolMap[schoolId]);
    }
}
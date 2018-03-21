import ballerina.net.http;

endpoint http:ServiceEndpoint helloWorldEP {
    port:9090
};

endpoint http:ClientEndpoint backendClientEP {
    targets: [{uri: "http://httpstat.us"}]
};

@http:ServiceConfig {
    basePath:"/hello"
}
service<http:Service> helloWorld bind helloWorldEP {

    @http:ResourceConfig {
        methods:["GET"],
        path:"/"
    }
    sayHello (endpoint outboundEP, http:Request request) {
        http:Response backendResponse =? backendClientEP -> forward("/200", request);
        _ = outboundEP -> forward(backendResponse);
    }
}

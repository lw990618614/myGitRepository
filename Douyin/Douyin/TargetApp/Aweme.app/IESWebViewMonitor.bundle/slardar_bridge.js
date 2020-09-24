
var global = typeof window !== 'undefined'
? window : typeof global !== 'undefined' ? global : typeof self !== 'undefined' ? self : {};
;

(function() {

 // 覆盖类型
 function jsIESLiveTimingMonitorCover(params, service) {
    params.serviceType = service
    if (window.webkit) {
        window.webkit.messageHandlers.iesLiveTimingMonitorCover.postMessage(formatMonitorParams(params));
    } else if (window.iesLiveTimingMonitorCover) {
        iesLiveTimingMonitorCover(formatMonitorParams(params));
    }
 }
 
 // 累加类型
function jsIESLiveTimingMonitorAccumulate(params, service) {
    params.serviceType = service
    if (window.webkit) {
        window.webkit.messageHandlers.iesLiveTimingMonitorAccumulate.postMessage(formatMonitorParams(params));
    } else if (window.iesLiveTimingMonitorAccumulate) {
        iesLiveTimingMonitorAccumulate(formatMonitorParams(params));
    }
}

// 透传类型
function jsIESLiveTimingMonitorReportDirectly(params, service) {
    params.serviceType = service
    if (window.webkit) {
        window.webkit.messageHandlers.iesLiveTimingMonitorReportDirectly.postMessage(formatMonitorParams(params));
    } else if (window.iesLiveTimingMonitorReportDirectly) {
        iesLiveTimingMonitorReportDirectly(formatMonitorParams(params));
    }
}

// 平均值类型
function jsIESLiveTimingMonitorAverage(params, service) {
    params.serviceType = service
    if (window.webkit) {
        window.webkit.messageHandlers.iesLiveTimingMonitorAverage.postMessage(formatMonitorParams(params));
    } else if (window.iesLiveTimingMonitorAverage) {
        iesLiveTimingMonitorAverage(formatMonitorParams(params));
    }
}

function formatMonitorParams(params) {
    params.url = window.location.href
    return JSON.parse(JSON.stringify(params))
}
 
 function jsIESLiveCalculateInitTime(jsDuration) {
    var urlStr = window.location.href;
    var body = {url:urlStr, duration:jsDuration}
    if (window.webkit) {
        window.webkit.messageHandlers.iesLiveCalculateInitTime.postMessage(body);
    } else if (window.iesLiveCalculateInitTime) {
        iesLiveCalculateInitTime(body);
    }
 }
 
 function jsIESLiveTimingMonitorRenderedMsg(params) {
    if (window.webkit) {
        window.webkit.messageHandlers.iesLiveTimingMonitorRenderedMsg.postMessage(params);
    } else if (window.iesLiveTimingMonitorRenderedMsg) {
        iesLiveTimingMonitorRenderedMsg(params);
    }
 }
    
 
 function onDomContentLoaded() {
    window.setTimeout(function() {
                      // native 计算webview初始化时间
                      if (window.history.length <= 1) {
                        jsIESLiveCalculateInitTime(performance.now());
                      }
                      var msg = {}
                      msg.didRendered = 1
                      jsIESLiveTimingMonitorRenderedMsg(msg)
                   }, 0)
 }

 
 var bridge = {}
 bridge.cover = jsIESLiveTimingMonitorCover
 bridge.accumulate = jsIESLiveTimingMonitorAccumulate
 bridge.reportDirectly = jsIESLiveTimingMonitorReportDirectly;
 bridge.average = jsIESLiveTimingMonitorAverage;
 global.jsIESLiveTimingMonitor = bridge;
 
 // Use the handy event callback
 window.addEventListener( "DOMContentLoaded", onDomContentLoaded );
 
 function sendError(errorDic) {
    var eventValue = {}
    var category = errorDic.category;
    eventValue[category] = 1;
    var message = {}
    message.ev_type = category
    message.event = eventValue
    jsIESLiveTimingMonitorAccumulate(message, 'overview')
 }
 
 var addEventListener = global.addEventListener;
 // https://developer.mozilla.org/zh-CN/docs/Web/Events/unhandledrejection
 if (addEventListener) {
 global.addEventListener('unhandledrejection', function (event) {
                         if (event) {
                         var reason = event.reason;
                         sendError({
                                          title: 'unhandledrejection',
                                          msg:'unhandledrejection' + reason,
                                          category: 'js_error_count',
                                          level: 'error'
                                          });
                         }
                         }, true);
 global.addEventListener('error', function (event) {
                         if (event) {
                         var target = event.target || event.srcElement;
                         var isElementTarget = target instanceof HTMLElement;
                         var url = target.src || target.href;
                         if (!isElementTarget) {
                         sendError({
                                          title:target.nodeName,
                                          msg:url,
                                          category:'js_error_count',
                                          level: 'error'
                                          });
                         };
                         }
                         }, true);
 }
 
})()

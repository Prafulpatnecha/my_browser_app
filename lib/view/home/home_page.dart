import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_browser_app/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey webViewKey = GlobalKey();
    InAppWebViewController? webViewController;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final controller = webViewController;
        if (controller != null) {
          if (await controller.canGoBack()) {
            controller.goBack();
            // controller.goForward();
            return false;
          }
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () async {
                      // final controller = webViewController;
                      // if (controller != null) {
                      //   // log(controller.getOriginalUrl().toString());
                      //   print(homeGetController.historyList);
                      // }
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView.builder(
                            itemCount: homeGetController.historyList.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                final controller = webViewController;
                                if(controller!=null)
                                  {
                                    controller.loadUrl(urlRequest: URLRequest(url: WebUri(homeGetController.historyList[index])));
                                  }
                                Get.back();
                              },
                              title: Text("History"),
                              leading: Icon(Icons.history),
                              subtitle: Text(homeGetController.historyList[index],maxLines: 1,),
                            ).paddingOnly(top: (index==0)?20:5),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.history)),
                IconButton(
                    onPressed: () async {
                      final controller = webViewController;
                      if (controller != null) {
                        controller.goBack();
                      }
                    },
                    icon: Icon(Icons.navigate_before)),
                IconButton(
                    onPressed: () {
                      final controller = webViewController;
                      if (controller != null) {
                        controller.reload();
                      }
                    },
                    icon: Icon(Icons.refresh)),
                IconButton(
                    onPressed: () {
                      final controller = webViewController;
                      if (controller != null) {
                        controller.goForward();
                      }
                    },
                    icon: Icon(Icons.navigate_next)),
                IconButton(
                    onPressed: () async {
                      final controller = webViewController;
                      if (controller != null) {
                        try {
                          controller.loadUrl(
                            urlRequest: URLRequest(
                              url: WebUri(homeGetController.linkUrl.value),
                            ),
                          );
                        } catch (e) {
                          log("Not Working");
                        }
                        // await controller.goTo(historyItem: WebHistoryItem(originalUrl: WebUri("https://www.google.com/search?q=")));
                      }
                    },
                    icon: Icon(Icons.home)),
              ],
            ),
            Obx(
              () => LinearProgressIndicator(
                color: Colors.blue,
                value: homeGetController.progress.value,
              ),
            ),
          ],
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromRect(Rect.largest, Rect.zero),
                    items: [
                      CheckedPopupMenuItem(
                        onTap: () {
                          final controller = webViewController;
                          if (controller != null) {
                            String linkString =
                                "https://in.search.yahoo.com/search;_ylt=Awr1QhExoA9nzFQMxyW6HAx.;_ylu=Y29sbwNzZzMEcG9zAzEEdnRpZAMEc2VjA3F1aWNrbGlua3M-?ei=UTF-8&fr=sfp-fba&fr2=p%3As%2Cv%3Asfp%2Cm%3Afeaturebar&p=";
                            homeGetController.linkUrlMethod(linkString);
                            controller.loadUrl(
                                urlRequest: URLRequest(
                              url: WebUri(linkString),
                            ));
                          }
                        },
                        child: Text("Yahoo"),
                      ),
                      CheckedPopupMenuItem(
                        onTap: () {
                          final controller = webViewController;
                          if (controller != null) {
                            String linkString =
                                "https://search.brave.com/search?q=";
                            homeGetController.linkUrlMethod(linkString);
                            controller.loadUrl(
                                urlRequest: URLRequest(
                              url: WebUri(linkString),
                            ));
                          }
                        },
                        child: Text("Brave"),
                      ),
                      CheckedPopupMenuItem(
                        onTap: () {
                          final controller = webViewController;
                          if (controller != null) {
                            String linkString =
                                "https://www.google.com/search?q=";
                            homeGetController.linkUrlMethod(linkString);
                            controller.loadUrl(
                                urlRequest: URLRequest(
                              url: WebUri(linkString),
                            ));
                          }
                        },
                        child: Text("Google"),
                      ),
                      CheckedPopupMenuItem(
                        onTap: () {
                          final controller = webViewController;
                          if (controller != null) {
                            String linkString =
                                "https://www.bing.com/search?pglt=41&q=";
                            homeGetController.linkUrlMethod(linkString);
                            controller.loadUrl(
                                urlRequest: URLRequest(
                              url: WebUri(linkString),
                            ));
                          }
                        },
                        child: Text("Edge"),
                      ),
                      CheckedPopupMenuItem(
                        onTap: () {
                          final controller = webViewController;
                          if (controller != null) {
                            String linkString =
                                "https://duckduckgo.com/?t=h_&q=";
                            homeGetController.linkUrlMethod(linkString);
                            controller.loadUrl(
                                urlRequest: URLRequest(
                              url: WebUri(linkString),
                            ));
                          }
                        },
                        child: Text("Duckduckgo"),
                      ),
                    ]);
              },
              icon: const Icon(Icons.more_vert)),
          title: const Text("My Browser"),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: SizedBox(
                child: TextField(
                  onSubmitted: (value) {
                    final controller = webViewController;
                    if (controller != null) {
                      try {
                        controller.loadUrl(
                          urlRequest: URLRequest(
                            url: WebUri(
                                homeGetController.linkUrl.value + "$value"),
                          ),
                        );
                      } catch (e) {
                        log("Not Working");
                      }
                      // await controller.goTo(historyItem: WebHistoryItem(originalUrl: WebUri("https://www.google.com/search?q=")));
                    }
                  },
                  decoration: InputDecoration(
                      label: Text("Search"),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ).paddingSymmetric(horizontal: 10),
              )),
        ),
        // ignore: deprecated_member_use
        body: InAppWebView(
          key: webViewKey,
          initialUrlRequest:
              URLRequest(url: WebUri("https://www.google.com/search?q=")),
          initialSettings: InAppWebViewSettings(
            allowsBackForwardNavigationGestures: true,
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          // onConsoleMessage: (controller, consoleMessage) {
          //   log("$controller<-------------------------------------------------------------------------");
          // },
          // onReceivedError: (controller, request, error) {

          // },
          onLoadResource: (controller, resource) {},
          onUpdateVisitedHistory: (controller, url, isReload) async {
            if ("https://www.google.com/webhp" != url.toString() &&
                "https://in.search.yahoo.com/?fr=sfp-fba" != url.toString() &&
                "https://search.brave.com/" != url.toString() &&
                "https://www.bing.com/?scope=web&cc=IN" != url.toString() &&
                "https://duckduckgo.com/?t=h_&q=" != url.toString()) {
              log("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>(${url.toString()})");
              // log(url.toString());
              homeGetController.historySetMethod(url.toString());
            }
          },
          // onTitleChanged: (controller, title) {
          // if("https://www.google.com/webhp"!=url.toString() && "https://in.search.yahoo.com/?fr=sfp-fba"!=url.toString() && "https://search.brave.com/"!=url.toString() && "https://www.bing.com/?scope=web&cc=IN"!=url.toString() && "https://duckduckgo.com/?t=h_&q="!=url.toString())
          // {
          //   homeGetController.historySetMethod(title.toString());
          //   log("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>(${title.toString()})");
          // }
          // }
          // log("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>(${url.toString()})");
          // },
          onProgressChanged: (controller, progress) {
            homeGetController.progressMethed(progress);
          },
        ),
      ),
    );
  }
}

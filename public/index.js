/** @typedef {{load: (Promise<unknown>); flags: (unknown)}} ElmPagesInit */

/** @type ElmPagesInit */
export default {
  load: async function(elmLoaded) {
    const app = await elmLoaded;
    console.log("App loaded", app);


    // plausible
    var a = window.location, r = window.document, t = window.localStorage, o = r.currentScript, s =  "https://plausible.iko.soy/api/event", l = t && t.plausible_ignore; function p(t) { console.warn("Ignoring Event: " + t) } function e(t, e) { if (/^localhost$|^127(\.[0-9]+){0,2}\.[0-9]+$|^\[::1?\]$/.test(a.hostname) || "file:" === a.protocol) return p("localhost"); if (!(window._phantom || window.__nightmare || window.navigator.webdriver || window.Cypress)) { if ("true" == l) return p("localStorage flag"); var i = {}; i.n = t, i.u = a.href, i.d = "x230.iko.soy", i.r = r.referrer || null, i.w = window.innerWidth, e && e.meta && (i.m = JSON.stringify(e.meta)), e && e.props && (i.p = JSON.stringify(e.props)); var n = new XMLHttpRequest; n.open("POST", s, !0), n.setRequestHeader("Content-Type", "text/plain"), n.send(JSON.stringify(i)), n.onreadystatechange = function() { 4 == n.readyState && e && e.callback && e.callback() } } } var i = window.plausible && window.plausible.q || []; window.plausible = e; for (var n, w = 0; w < i.length; w++)e.apply(this, i[w]); function d() { n !== a.pathname && (n = a.pathname, e("pageview")) } var u, c = window.history; c.pushState && (u = c.pushState, c.pushState = function() { u.apply(this, arguments), d() }, window.addEventListener("popstate", d)), "prerender" === r.visibilityState ? r.addEventListener("visibilitychange", function() { n || "visible" !== r.visibilityState || d() }) : d()
  },
  flags: function() {
    return "You can decode this in Shared.elm using Json.Decode.string!";
  },
};

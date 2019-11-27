try {
  var urlParams = new URLSearchParams(window.location.search);
  var refresh = urlParams.get("refresh");

  if (refresh) {
    var seconds = parseInt(refresh, 10);
    setTimeout(function() {
      window.location.reload();
    }, seconds * 1000);
  }
} catch (err) {
  console.error("Could not set up auto-refresh, error:", err);
}

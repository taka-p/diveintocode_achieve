/**
 * Common.js
 * 共用の処理を定義
 * 共通モジュールはUtilに切り分ける
**/

/* 定数 */
var consts = {
  VANISING_ALERT_TIME: 1500
};

/* readyイベント */
$(function() {
  // alertを1500掛けて消す
  if ($(".js_alert").length) {
    Util.elmVanising($(".js_alert"), consts.VANISING_ALERT_TIME);
  }
});

/* loadイベント */
window.onload = function() {}

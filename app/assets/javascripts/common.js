"use strict";

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
$(function () {
    var util = new Util;

    // alertを1500掛けて消す
    var $js_alert = $(".js_alert");
    if ($js_alert.length) {
        util.elmVanising($js_alert, consts.VANISING_ALERT_TIME);
    }
    // 画像アップロード時に画像をプレビュー
    var $js_upload_file = $("#js_upload_file");
    if ($js_upload_file.length) {
        util.uploadThumb($js_upload_file, $("#js_upload_replace"));
    }
});

/* loadイベント */
window.onload = function () {};

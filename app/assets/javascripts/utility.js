"use strict";

/**
 * Utility.js
 * 共用のモジュールを定義
 **/

function Util(){}

/** elmVanising
 * @params
 * elm - 消したい要素
 * secont - 消すまでのインターバル
 **/
Util.prototype.elmVanising = function (elm, secont) {
    var $vanisingElm = $(elm);

    function vanising() {
        $vanisingElm.fadeOut();
    }

    setTimeout(vanising, secont);
    return false;
};

/** uploadThumb
 * @params
 * inputElm - input[type=file]の要素オブジェクト
 * replaceArea - リプレイスしたい画像
 **/
Util.prototype.uploadThumb = function (inputElm, replaceArea) {
    inputElm.change(function () {
        var file = $(this).prop('files')[0],
            replaceImg = replaceArea.find('img');

        // 画像以外は処理を停止
        if (file.type.match('image*') === null) {
            // クリア
            $(this).val('');
            replaceImg.hide();
            replaceArea.append('<p class="text-danger h-tal h-fwb"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> 不正なファイル形式です</p>');
            return;
        }

        // 画像表示
        var reader = new FileReader();
        reader.onload = function () {
            var img_src = reader.result;
            replaceArea.find('p').remove();
            replaceImg.attr('src', img_src).show();
        };
        reader.readAsDataURL(file);
    });
};

/**
 * Utility.js
 * 共用のモジュールを定義
**/

Util = {
    /** elmVanising
      * params
      * elm - 消したい要素
      * secont - 消すまでのインターバル
    **/
    // 実行時、引数に渡された要素をsecont秒後に消す
    elmVanising: function(elm, secont) {
      var $vanisingElm = $(elm);

      function vanising() {
        $vanisingElm.fadeOut();
      }
      setTimeout(vanising, secont);
      return false;
    }
};

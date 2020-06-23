$(document).on('turbolinks:load', function() {
  // タブのDOMを取得し、変数で定義
  let tabs = document.getElementsByClassName("menu");
  // tabsを配列に変換する
  tabsAry = Array.prototype.slice.call(tabs);

  // クラスの切り替えをtabSwitch関数で定義
  function tabSwitch() {
    // 全てのactiveクラスのうち、最初の要素を削除（"[0]は、最初の要素の意味"）
    document.getElementsByClassName("active")[0].classList.remove("active");

    // クリックしたタブにactiveクラスを追加
    this.classList.add("active");

    // コンテンツの全てのshowクラスのうち、最初の要素を削除
    document.getElementsByClassName("show")[0].classList.remove("show");

    // 何番目の要素がクリックされたかを、配列tabsから要素番号を取得
    const index = tabsAry.indexOf(this);

    // クリックしたmypage-contentクラスにshowクラスを追加する
    document.getElementsByClassName("mypage-content")[index].classList.add("show");
  }

  // タブメニューの中でクリックイベントが発生した場所を探し、下で定義したtabSwitch関数を呼び出す
  tabsAry.forEach(function(value) {
    value.addEventListener("click", tabSwitch);
  });



  let tabs2 = document.getElementsByClassName("main-low-menu");
  // tabsを配列に変換する
  tabsAry2 = Array.prototype.slice.call(tabs2);

  // クラスの切り替えをtabSwitch関数で定義
  function tabSwitch2() {
    // 全てのactiveクラスのうち、最初の要素を削除（"[0]は、最初の要素の意味"）
    document.getElementsByClassName("active2")[0].classList.remove("active2");

    // クリックしたタブにactiveクラスを追加
    this.classList.add("active2");

    // コンテンツの全てのshowクラスのうち、最初の要素を削除
    document.getElementsByClassName("show2")[0].classList.remove("show2");

    // 何番目の要素がクリックされたかを、配列tabsから要素番号を取得
    const index = tabsAry2.indexOf(this);

    // クリックしたmypage-contentクラスにshowクラスを追加する
    document.getElementsByClassName("main-low-content")[index].classList.add("show2");
  }

  // タブメニューの中でクリックイベントが発生した場所を探し、下で定義したtabSwitch関数を呼び出す
  tabsAry2.forEach(function(value) {
    value.addEventListener("click", tabSwitch2);
  });

});
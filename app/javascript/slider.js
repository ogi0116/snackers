$(document).ready(function(){
    $('.slider').slick({
    autoplay:true,
    autoplaySpeed: 2000,
    slidesToShow:3,
    infinite:true,
    slidesToScroll:1,
    prevArrow: '<div class="slick-prev"></div>', // 前へボタンのHTMLコードを指定
    nextArrow: '<div class="slick-next"></div>', // 次へボタンのHTMLコードを指定
  });
});

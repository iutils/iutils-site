<%@ page contentType="text/html;charset=UTF-8" %>
<footer class="footer">
  <p>${empty site.copyright?'CopyRight©2016 iutils.cn All Rights Reserved.':site.copyright}</p>
</footer>
<div class="amz-toolbar" id="amz-toolbar" style="right: 10px;">
  <a href="#top" title="回到顶部" class="am-icon-btn am-icon-arrow-up" id="amz-go-top"></a>
  <a href="#" title="在线聊天【暂无发布】" id="commenting" class="am-icon-faq am-icon-btn am-icon-commenting-o rotate"></a>
</div>
<script>
  $(function () {
    //amz-toolbar事件监听
    $(window).scroll(function(){
      var sc=$(window).scrollTop();
      if(sc>10){
        $("#amz-go-top").addClass("am-active");
      }else{
        $("#amz-go-top").removeClass("am-active");
      }
    });
    $("#amz-go-top").click(function(){
      var sc=$(window).scrollTop();
      $('body,html').animate({scrollTop:0},500);
    });
    $("#commenting").click(function(){

    });
  });
</script>
<script>
  //百度统计
  var _hmt = _hmt || [];
  (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?46f3fb08caf307dd3770040a8704ed27";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
  })();
</script>

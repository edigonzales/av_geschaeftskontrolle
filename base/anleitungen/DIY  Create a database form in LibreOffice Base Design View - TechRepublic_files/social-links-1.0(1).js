define(["jquery","version!fly/managers/debug","version!fly/utils/string-vars","version!fly/components/base"],function(e,t,n){var r=e.support.touch?"vclick":"click",i=t.init("socialLinks");e.widget("fly.socialLinks",e.fly.base,{options:{title:"",url:"",description:"",shortUrl:"",data:{},popupWidth:620,popupHeight:440},isLoading:!1,popupId:"popup",linkId:"link",links:{facebook:"http://www.facebook.com/sharer.php?u={url}&t={title}",reddit:"http://reddit.com/submit?url={url}&title={title}",digg:"http://digg.com/submit?url={url}&title={title}",stumbleupon:"http://www.stumbleupon.com/submit?url={url}",twitter:function(e){var t="https://twitter.com/intent/tweet?text={title}&related={related}";return t+(e.shortUrl?"&url={shortUrl}&counturl={url}":"&url={url}")},delicious:"http://del.icio.us/post?url={url}&title={title}",googleplus:"https://plus.google.com/share?url={url}&utm_content={title}&utm_campaign=&utm_medium=share%2Bbutton",linkedin:"http://www.linkedin.com/shareArticle?mini=true&url={url}&title={title}&summary={description}",pinterest:"http://pinterest.com/pin/create/button/?url={url}&media={media}&description={description}",tumblr:"http://www.tumblr.com/share/link?url={url}&description={description}",print:function(){return window.print(),!1},email:"mailto:?subject={title}&body={url}%0D%0D{description}"},_create:function(){var e=this.options,t={};this._setup(),t[r+" [data-"+this.popupId+"]"]="_handlePopup",t[r+" [data-"+this.linkId+"]"]="_handleLink",this._on(this.$element,t)},_handlePopup:function(t){var n=e(t.currentTarget),r=n.data(this.popupId);t.preventDefault(),this.$el=n,this._trigger("clicked",null,{el:n,name:r}),this.popup(r)},_handleLink:function(t){var n=e(t.currentTarget),r=n.data(this.linkId);t.preventDefault(),this.$el=n,this._trigger("clicked",null,{el:n,name:r}),this.link(r)},_getLink:function(t){var r=this.links[t.toLowerCase()],i=this._getLinkData();return e.isFunction(r)&&(r=r(i)),r=n.compile(r,i,["urlencode"]),r},setLink:function(e,t){this.links[e]=t},_getLinkData:function(){var t=this.options;return e.extend({title:t.title,description:t.description,url:t.url,shortUrl:t.shortUrl},t.data)},popup:function(e){var t=this._getLink(e),n=this._getPopUpCoords(),r=this.$el;t&&(window.open(t,"button_share","width="+n.width+", height="+n.height+", "+"left="+n.left+", top="+n.top+", "+"personalbar=0, toolbar=0, scrollbars=1, resizable=1"),this._trigger("loaded",null,{name:e,el:r}))},link:function(e){var t=this._getLink(e),n=this.$el;t&&(this._trigger("loaded",null,{name:e,el:n}),window.location=t)},_getPopUpCoords:function(e,t){var n=this.options,r=e||n.popupWidth,i=t||n.popupHeight,s=screen.width,o=screen.height;return{left:Math.round(s/2-r/2),top:o>i?Math.round(o/2-i/2):0,width:s>r?r:s,height:o>i?i:o}}})})
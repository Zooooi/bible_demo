package projectComponents.bible.act
{
	import mx.core.UIComponent;
	
	import JsC.events.JEvent;
	import JsC.mvc.ActionUI;
	import JsC.mvc.Model;
	
	import JsF.components.act.JScrollerActV;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.views.panel.BibleReader;
	import projectComponents.bible.ex.JScrollerCtrlBibleVerseList;
	
	[Event(name="ONSTART", type="JsC.events.JEvent")]
	[Event(name="ONEND", type="JsC.events.JEvent")]
	
	public class ActBibleContent extends ActionUI
	{
		private var view:BibleReader
		private var actBible:JScrollerCtrlBibleVerseList
		private var sql:BibleDB
		private var scrollerCtrl:JScrollerActV
		
		public function ActBibleContent(_vi:UIComponent=null)
		{
			super(_vi);
			view = BibleReader(_vi)
		}	
		
		override public function _addModel(_value:Model):void
		{
			if (_value is BibleDB)
			{
				sql = BibleDB(_value)
				init_internal_bible()
			}
		}
		
		
		protected function onScrollEvent(event:JEvent):void
		{
			dispatchEvent(new JEvent(event.type))
		}	
		
		
		private function init_internal_bible():void
		{
			scrollerCtrl = new JScrollerActV(view.$scroller)//scroller
			scrollerCtrl.addEventListener(JEvent.ONSTART,onScrollEvent)
			scrollerCtrl.addEventListener(JEvent.ONEND,onScrollEvent)
			actBible = new JScrollerCtrlBibleVerseList(scrollerCtrl,sql)
		}
		
		
		public function updateData():void
		{
			actBible.load()
		}
		
		public function stop():void
		{
			scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
		}
	}
}
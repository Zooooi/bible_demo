package projectComponents.bible.act
{
	import mx.core.UIComponent;
	
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActV;
	
	import projectComponents.bible.ext.JScrollerCtrlBibleVerseList;
	import projectComponents.bible.viewers.panel.BibleReader;
	
	[Event(name="ONSTART", type="JsC.events.JEvent")]
	[Event(name="ONEND", type="JsC.events.JEvent")]
	
	public class ActMain_BibleContent extends ActMain_BibleBase
	{
		
		private var scrollerCtrl:JScrollerActV
		private var actBibleScroller:JScrollerCtrlBibleVerseList
		
		protected var view:BibleReader;
		
		public function ActMain_BibleContent(_vi:UIComponent=null)
		{
			super(_vi);
			view = BibleReader(_vi)
			init_internal_bible()
			
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
			
			actBibleScroller = new JScrollerCtrlBibleVerseList(scrollerCtrl,__sqlBible)
			actBibleScroller.addEventListener(JEvent.NEWGAME,onItemJEvent)
			actBibleScroller.addEventListener(JEvent.SELECT,onItemJEvent)
			
		}
		
		protected function onItemJEvent(event:JEvent):void
		{
			trace(event)
		}		
		
		public function updateData():void
		{
			actBibleScroller.load()
		}
		
		public function stop():void
		{
			scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
		}
	}
}
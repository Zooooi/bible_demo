package projectComponents.bible.act
{
	import mx.core.UIComponent;
	
	import JsC.events.JEvent;
	
	import JsF.components.scroller.act.JScrollerActV;
	
	import projectClass.vo.o.BibleOB;
	
	import projectComponents.bible.act.item.ActItem_BibleVerseList;
	import projectComponents.bible.act.panel.ActPanel_Exercise;
	import projectComponents.bible.ext.JScrollerCtrlBibleVerseList;
	import projectComponents.bible.viewers.item.BibleVerseList_item;
	import projectComponents.bible.viewers.panel.BibleExercise;
	import projectComponents.bible.viewers.panel.BibleReader;
	
	[Event(name="ONSTART", type="JsC.events.JEvent")]
	[Event(name="ONEND", type="JsC.events.JEvent")]
	
	public class ActMain_BibleContent extends ActMain_Bible_Base
	{
		
		[Bindable]private static var degree:uint = 3
		
		private var scrollerCtrl:JScrollerActV
		private var actBibleScroller:JScrollerCtrlBibleVerseList
		
		protected var view:BibleReader;
		
		protected var vo:BibleOB
		
		public function ActMain_BibleContent(_vi:UIComponent=null)
		{
			super(_vi);
			view = BibleReader(_vi)
			initCtrl()
		}	
		
		
		protected function onScrollEvent(event:JEvent):void
		{
			dispatchEvent(new JEvent(event.type))
		}	
		
		
		private function initCtrl():void
		{
			/** scroller */			
			scrollerCtrl = new JScrollerActV(view.$scroller)//scroller
			scrollerCtrl.addEventListener(JEvent.ONSTART,onScrollEvent)
			scrollerCtrl.addEventListener(JEvent.ONEND,onScrollEvent)
			
			/** scroller for bible */	
			actBibleScroller = new JScrollerCtrlBibleVerseList(scrollerCtrl,__sqlBible)
			actBibleScroller.addEventListener(JEvent.ITEM_CREATE,function(event:JEvent):void
			{
				var _item:BibleVerseList_item = BibleVerseList_item(event._obj)
				var itemCtrl:ActItem_BibleVerseList = new ActItem_BibleVerseList(_item)
				itemCtrl.addEventListener(JEvent.NEWGAME,onItemJEvent)	
				itemCtrl.addEventListener(JEvent.SELECT,onItemJEvent)
				itemCtrl._destory_From_View(_item)
				itemCtrl.addEventListener(JEvent.DESTORY,function():void{itemCtrl = null})
				vo = _item.$data
			})
		}
		
		
		private function onItemJEvent(event:JEvent):void
		{
			view.currentState = "selected"
			switch(event.type)
			{
				case JEvent.NEWGAME:
					newGame(BibleOB(event._vo))
					break
				
				case JEvent.SELECT:
					
					break
			}
		}
		
		
		public function updateData():void
		{
			actBibleScroller.load()
			//newGame(vo)
		}
		
		public function stop():void
		{
			scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
		}
		
		public function newGame(_vo:BibleOB):void
		{
			var _exercise:BibleExercise = new BibleExercise
			_exercise.$degree = degree
			_exercise.$data = _vo
			_exercise.addEventListener(JEvent.CHANGED,function(event:JEvent):void{degree = _exercise.$degree })
				
			__actViews.popUp(_exercise)
				
			var _act:ActPanel_Exercise = new ActPanel_Exercise(_exercise)
			_act.addEventListener(JEvent.DESTORY,function(event:JEvent):void{_act = null})
			_act._destory_From_View(_exercise)
		}
	}
}
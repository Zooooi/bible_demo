package projectComponents.bible.act
{
	import mx.core.UIComponent;
	
	import JsC.events.JEvent;
	import JsC.events.JState;
	
	import JsF.components.scroller.act.JScrollerActV;
	
	import projectComponents.bible.act.item.ActItem_BibleVerseList;
	import projectComponents.bible.act.panel.ActPanel_Exercise;
	import projectComponents.bible.ext.JScrollerCtrlBibleVerseList;
	import projectComponents.bible.viewers.item.BibleVerseList_item;
	import projectComponents.bible.viewers.panel.BibleExercise;
	import projectComponents.bible.viewers.panel.BibleReader;
	import projectComponents.bible.vo.BibleOB;
	import projectComponents.bible.vo.ExerciseVO;
	
	[Event(name="ONSTART", type="JsC.events.JEvent")]
	[Event(name="ONEND", type="JsC.events.JEvent")]
	
	
	public class ActMain_BibleContent extends ActMain_Bible_Base
	{
		
		[Bindable]private static var voExercise:ExerciseVO
		
		private var scrollerCtrl:JScrollerActV
		private var actBibleScroller:JScrollerCtrlBibleVerseList
		
		protected var view:BibleReader;
		protected var vo:BibleOB
		protected var _item:ActItem_BibleVerseList
		
		public function ActMain_BibleContent(_vi:UIComponent=null)
		{
			super(_vi);
			view = BibleReader(_vi)
			voExercise = new ExerciseVO
			initCtrl()
		}	
		
		
		protected function onScrollEvent(event:JEvent):void
		{
			view.dispatchEvent(new JState(JState.HOME))
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
				itemCtrl._destory_From_View(_item,function(event:JEvent):void{itemCtrl = null})
				vo = _item.$data
			})
		}
		
		
		private function onItemJEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.NEWGAME:
					var _ui:UIComponent = newGame(BibleOB(event._vo))
					_item = ActItem_BibleVerseList(event.currentTarget)
					_item._destory_From_View(_ui,function(event:JEvent):void{_item.dispatchEvent(new JEvent(JEvent.FINISH))})
					_item._getView().enabled = false
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
		
		public function newGame(_vo:BibleOB):BibleExercise
		{
			var _exercise:BibleExercise = new BibleExercise
			_exercise._exercise = voExercise
			_exercise._data = _vo
			__actViews.popUp(_exercise)
			view.dispatchEvent(new JState(JState.POPUP))
				
			var _act:ActPanel_Exercise = new ActPanel_Exercise(_exercise)
			_exercise._setCtrl(_act)
			_act._destory_From_View(_exercise,function(event:JEvent):void{_item._getView().enabled = true;_act = null	;view.dispatchEvent(new JState(JState.HOME))})
			return _exercise
		}
	}
}
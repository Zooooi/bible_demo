package projectComponents.bible.ctrl
{
	import flash.events.Event;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;
	
	import spark.components.Group;
	import spark.components.Scroller;
	
	import JsC.events.JEvent;
	import JsC.mvc.Controller;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.model.CreateBibleModel;
	
	[Event(name="ALLCOMPLETE", type="JsC.events.JEvent")]
	public class CreateBibleBase extends Controller
	{
		
		protected var sql:BibleDB
		protected var scroller:Scroller
		protected var scrollerCtrl:JScrollerActBase
		
		protected var cTotal:uint
		protected var cLength:uint
		protected var nLength:uint
		
		protected var nCount:uint;
		protected var nUpdate:uint;
		protected var nUpdate_debug:uint;
		protected var nChange_debug:uint;
		
		protected var nInterval:uint
		
		protected var nValue:Number
		
		protected var currModel:CreateBibleModel
		
		protected const actInit:String = "actInit"
		protected const actNext:String = "actNext"
		protected const actPrev:String = "actPrev"
		protected var act:String = actInit
		protected var grV:Group
		
		
		public function CreateBibleBase(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			sql = _data
			scrollerCtrl = _ctrl;
			scroller = scrollerCtrl._getScroller()
			
			currModel = new CreateBibleModel
			_model = currModel
		}
		
		
		
		public function init():void
		{
			act = actInit
			nValue = 0;
			nCount = 0;
		}
		
		public function next():void
		{
			act = actNext
			nValue = 0;
			nCount = 0;
		}
		
		
		public function prev():void
		{
			act = actPrev
			nValue = 0;
			nCount = 0;
		}
		
		
		protected function addItem(_start:uint,_end:uint):void
		{
			nLength = _end - _start
			for (var i:int = _start; i <_end; i++) 
			{
				var _item:UIComponent = createItem(i);
				if (act != actInit)
				{
					_item.addEventListener(FlexEvent.CREATION_COMPLETE,onItemEvent)
					_item.addEventListener(Event.ADDED_TO_STAGE,onItemEvent)
				}
				_item.addEventListener(Event.REMOVED_FROM_STAGE,onItemEvent)
				switch(act)
				{
					case actNext:
					case actInit:
						grV.addElement(_item)
						break;
					
					case actPrev:
						grV.addElementAt(_item,nLength-(nLength-(i-_start)));
						break
				}
			}
		}
		
		
		protected function delItem():void
		{
			var i:uint;
			switch(act)
			{
				case actNext:
					for (i = 0; i <nLength; i++) 
					{
						grV.removeElementAt(0);
					}
					break;
				
				case actPrev:
					for (i = 0; i <nLength; i++) 
					{
						grV.removeElementAt(grV.numElements - 1)
					}
					break
			}
			nUpdate = 0
			nUpdate_debug = 0
			nChange_debug = 0
			
			
			
		}
		
		protected function ondelevent():void
		{
			scroller.viewport.addEventListener(EffectEvent.EFFECT_START,onEffectEvent)
			scroller.viewport.addEventListener(EffectEvent.EFFECT_END,onEffectEvent)
			scroller.viewport.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onViewPortChange)
		}
			
		protected function onEffectEvent(event:EffectEvent):void
		{
			event.preventDefault()
			trace("onEffectEvent",event.type)
			onAllComplete(10)
		}
		protected function onViewPortChange(event:PropertyChangeEvent):void
		{
			event.preventDefault()
			nUpdate_debug ++ ;
			trace("onViewPortChange",nUpdate_debug)
			onAllComplete(80)
		}
		
		
		private function onAllComplete(_time:uint):void
		{
			dispatchEvent(new JEvent(JEvent.ALLCOMPLETE))
			clearInterval(nInterval)
			nInterval = setInterval(function():void{
				clearInterval(nInterval)
				dispatchEvent(new JEvent(JEvent.ALLCOMPLETE))
				scroller.viewport.removeEventListener(EffectEvent.EFFECT_START,onEffectEvent)
				scroller.viewport.removeEventListener(EffectEvent.EFFECT_END,onEffectEvent)
				scroller.viewport.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onViewPortChange)
				scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
			},_time)
			
		}
		
		
		protected function onItemEvent(event:Event):void
		{
			var item:UIComponent = UIComponent(event.currentTarget)
			item.removeEventListener(event.type,arguments.callee);
			switch(event.type)
			{
				case Event.ADDED_TO_STAGE:
				case FlexEvent.CREATION_COMPLETE:
					nCount++;
					if (nCount == nLength *2) 
					{
						nCount = 0
						delItem();
					}
					break;
			}
		}
		
		
		
		protected function createItem(_index:uint):UIComponent
		{
			return new UIComponent
		}
		
	}
}

class SQL_Data
{
	
}


package projectComponents.bible.ctrl
{
	
	import mx.core.UIComponent;
	
	import spark.components.HGroup;
	
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	import projectClass.vo.o.BibleOB;
	
	import projectComponents.bible.views.item.VolumeLabel;
	import projectComponents.bible.views.item.VolumeNumber_Radio;
	
	public class CreateBible_ChapterMenu extends CreateBible_Base
	{
		private var gr:HGroup
		private var vMenu:Vector.<BibleOB>
		private var nMenu:uint
		
		public function CreateBible_ChapterMenu(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			super(_ctrl,_data);
			
			cTotal = 70;
			cLength = cTotal /2
			gr = scrollerCtrl._getContentH()
			initCtrl()
		}
		
		
		private function initCtrl():void
		{
			scrollerCtrl.$slider = 5;
			scrollerCtrl.addEventListener(JEvent.ONEND,function():void{next()})
			scrollerCtrl.addEventListener(JEvent.ONSTART,function():void{prev()})
		}
		
		private function initValue():void
		{
			nMenu = cTotal
			var vData:Vector.<Object> = sql.getVoumes()
			vMenu = new Vector.<BibleOB>
			for (var i:int = 0; i < vData.length; i++) 
			{
				var _vo:BibleOB = currModel.getVolumesData(sql,i);
				var _itemVo:BibleOB = new BibleOB
				_itemVo.contentTitle = _vo.full_name 
				_itemVo.chapterLength = _vo.chapter 
				vMenu.push(_itemVo);
				for (var j:int = 0; j < _vo.chapter; j++) 
				{
					_itemVo = new BibleOB
					_itemVo.chapter = j + 1
					vMenu.push(_itemVo);
				}
			}
		}
		
		
		override public function init():void
		{
			super.init()
			initValue()
			addItem(0,cTotal)
			nMenu = cTotal
		}
		
		
		override public function next():void
		{
			super.next()
			nMenu += cLength
			addItem(nMenu - cLength,nMenu)
		}
		
		
		override public function prev():void
		{
			super.prev()
			if (nMenu > cTotal){
				nMenu -= cTotal
				addItem(nMenu - cLength,nMenu)
				nMenu += cLength
			}else{
				scrollerCtrl.dispatchEvent(new JEvent(JEvent.READY))
			}
		}
		
		
		
		
		override protected function createItem(_index:uint):UIComponent
		{
			var _item:UIComponent 
			var vo:BibleOB
			vo = vMenu[_index]
			if (vo.contentTitle==null)
			{
				var _number:VolumeNumber_Radio = new VolumeNumber_Radio
				_number.label = String(vMenu[_index].chapter)
				_item = _number
				if (!vo.testament)
				{
					_number.currentState = BibleOB.old_testament
				}else{
					_number.currentState = BibleOB.new_testament
				}
			}else{
				var _text:VolumeLabel = new VolumeLabel
				_text.$data = vMenu[_index]
				_item = _text
			}
			return _item
		}
		
		
		
		
	}
}
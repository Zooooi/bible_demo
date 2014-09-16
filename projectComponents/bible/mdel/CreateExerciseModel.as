package projectComponents.bible.mdel
{
	import JsC.events.JEvent;
	import JsC.mvc.Model;
	
	public class CreateExerciseModel extends Model
	{
		[Bindable] public var nDegree:uint = 4;
			
		private const nMin:uint = 1
		private const nMax:uint = 7
			
			
		private const cnChar:String = "，。？（）“”‘’：；、！·"
			
		protected var content:String	
		
		public var aText:Vector.<String>
		protected var aItem:Vector.<ItemText>
		
		private var nCount:uint
		public function CreateExerciseModel()
		{
			super();
			aItem = new Vector.<ItemText>
			nCount = 0
		}
		
		
		/**
		 * 顯示標點符號 
		 */		
		public function isSymbol(_text:String):Boolean
		{
			var _b:Boolean
			if (nDegree != nMax){
				_b = cnChar.indexOf(_text)>-1?true:false
			}else{
				_b = false
			}
			return _b
		}
		
		
		public function pushText(_text:String):void
		{
			var _item:ItemText = new ItemText(_text,nCount)
			nCount ++
			aItem.push(_item)
		}
		
		/**
		 * 凍結 Target 
		 */		
		public function isFreeze():Boolean
		{
			var _b:Boolean
			switch(nDegree)
			{
				case nMax -1:
					_b = true
					break;
			}
			return false
		}
		
		
		
		public function setTargetText(_function:Function):void
		{
			addEventListener(JEvent.RUN,_function)
			var _num:Number
			switch(nDegree)
			{
				case 1:
					_num = 0.5
					break;
				case 2:
					_num = 0.4
					break;
				case 3:
					_num = 0.3
					break;
				case 4:
					_num = 0.2
					break;
				case 5:
					_num = 0.1
					break;
				default:
					_num = 0
					break
			}
			
			var _length:uint = Math.round(aItem.length * _num)
			var _array:Vector.<ItemText> = new Vector.<ItemText>
			var i:int
			for (i = 0; i < _length; i++) 
			{
				var _n:uint = Math.random()*(aItem.length-1)
				var _item:ItemText = aItem[_n]
				aItem.splice(_n,1)
				_array.push(_item)
			}
			
			for (i = 0; i < _array.length; i++) 
			{
				var _event:JEvent = new JEvent(JEvent.RUN)
				_event.text = _array[i].text
				_event.id = _array[i].id
				dispatchEvent(_event)
			}
			
			removeEventListener(JEvent.RUN,_function)
		}
		
		
		public function setSourceText(_function:Function):void
		{
			addEventListener(JEvent.RUN,_function)
			var i:int
			var _array:Vector.<ItemText> = new Vector.<ItemText>
			while(aItem.length)
			{
				var _n:uint = Math.random()*(aItem.length-1)
				var _item:ItemText = aItem[_n]
				aItem.splice(_n,1)
				_array.push(_item)
			}
			
			for (i = 0; i < _array.length; i++) 
			{
				var _event:JEvent = new JEvent(JEvent.RUN)
				_event.text = _array[i].text
				_event.id = _array[i].id
				dispatchEvent(_event)
			}
			
			removeEventListener(JEvent.RUN,_function)
		}
	}
}

class ItemText
{
	public var text:String
	public var id:uint
	public function ItemText(_text:String,_id:uint)
	{
		text = _text
		id = _id
	}
}

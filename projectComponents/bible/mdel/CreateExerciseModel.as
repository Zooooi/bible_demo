package projectComponents.bible.mdel
{
	import JsC.events.JEvent;
	import JsC.mvc.Model;
	import JsC.string.Maths;
	
	import projectComponents.bible.vo.ExerciseVO;
	
	public class CreateExerciseModel extends Model
	{
		[Bindable] public var nDegree:uint = 4;
		
		private static var _exercise:ExerciseVO
		
		private const nMin:uint = 1
		private const nMax:uint = 7
		
		private const cGif:uint = 3
		private const cGifCondition:uint = 7	
		private var nGifCounter:uint;
		
		private const cnChar:String = "，。？（）“”‘’：；、！·"
		private const enChar:String = ",.?()'\":;!`"
			
		
			
		protected var content:String	
		
		public var aText:Vector.<String>
		protected var aItem:Vector.<ItemText>
		
		private var nCount:uint
		public function CreateExerciseModel()
		{
			super();
			aItem = new Vector.<ItemText>
			nCount = 0
			nGifCounter = 0
		}
		
		
		
		public function setText(_value:String):String
		{
			var _text:String = _value
			_text = _text.replace(new RegExp(/（.*?）/),"")
			_text = _text.replace(new RegExp(/(.*?)/),"")
			return _text
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
					_num = 0.6
					break;
				case 2:
					_num = 0.5
					break;
				case 3:
					_num = 0.4
					break;
				case 4:
					_num = 0.3
					break;
				case 5:
					_num = 0.2
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
		
		public function setExerciseVo(_vo:ExerciseVO):void
		{
			_vo.fast = _vo.compare
			var _fast:uint = _vo.fast
			var _tipsNumber:Number
			var _compareNumber:Number
			var _fastNumber:Number
			var _gif:Number
			switch(nDegree)
			{
				case 1:
					_tipsNumber = 0.37
					_compareNumber = 0.37
					_fastNumber = 0.24
					break;
				case 2:
					_tipsNumber = 0.35
					_compareNumber = 0.35
					_fastNumber = 0.22
					break;
				case 3:
					_tipsNumber = 0.33
					_compareNumber = 0.33
					_fastNumber = 0.2
					break;
				case 4:
					_tipsNumber = 0.29
					_compareNumber = 0.29
					_fastNumber = 0.18
					break;
				case 5:
					_tipsNumber = 0.22
					_compareNumber = 0.22
					_fastNumber = 0.16
					break
				case 6:
					_tipsNumber = 0.15
					_compareNumber = 0.15
					_fastNumber = 0.14
					break
				case 7:
					_tipsNumber = 0.15
					_compareNumber = 0.15
					_fastNumber = 0.14
					break
			}
				
			_vo.score = 10;
			_vo.gif = Maths.float((nDegree-1)*0.1 + 0.4) *10
			_vo.gif_fast = Maths.float((nDegree-1)*0.2 + 0.5) *10
			_vo.dropSecond = (nDegree-1)*0.3 + 2.5
				
			_vo.tips *= _tipsNumber
			_vo.compare *= _compareNumber
			_vo.fast *= _fastNumber
				
			_vo.tips_total = _vo.tips
			_vo.compare_total = _vo.compare
			_vo.fast_total = _vo.fast
		}
		
		
		public function getGif(_vo:ExerciseVO):void
		{
			nGifCounter++
			if (nGifCounter == cGifCondition)
			{
				var _r:uint = Math.round(Math.random()*(cGif-1))
				switch(_r)
				{
					case 0:
						_vo.tips++
						break;
					case 1:
						_vo.compare++
						break;
					case 2:
						_vo.fast++
						break;
				}
				nGifCounter = 0
			}
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

package projectComponents.bible.vo
{
	import JsC.mvc.VO;
	
	public class BibleScore extends VO
	{
		private var _exercise:ExerciseVO
		
		[Bindable]public var sTime:String
		[Bindable]public var nSecond:uint
		[Bindable]public var nWrong:int
		[Bindable]public var nRight:int
		[Bindable]public var nCount:uint
		
		
		[Bindable]public var score_right:uint
		[Bindable]public var score_gif:uint
		[Bindable]public var score_max:uint
		[Bindable]public var score_percent:uint
		
		
		public function BibleScore(obj:Object=null)
		{
			super(obj);
		}
		
		
		override public function _addVO(_vo:VO):void
		{
			if (_vo is ExerciseVO)
			{
				_exercise = ExerciseVO(_vo)
					
				score_right = nRight * _exercise.score
				score_gif = (_exercise.compare +_exercise.tips + _exercise.fast)*_exercise.gif
				score_max = nCount * _exercise.score + (_exercise.compare_total +_exercise.tips_total + _exercise.fast_total)*_exercise.gif
				score_percent = Math.round((score_right+score_gif) / score_max*100)
			}
			
		}
	}
}
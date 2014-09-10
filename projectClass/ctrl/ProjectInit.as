package projectClass.ctrl
{
	
	import JsC.mvc.Controller;
	import JsC.shell.ShellSystem;

	
	public class ProjectInit extends Controller
	{
		public function ProjectInit()
		{
			ShellSystem.init()
		}
	}
}
using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

public class cppPluginTest : MonoBehaviour {
	// plugin
	[DllImport("CPPLib")]	// dll文件只能放在Assets目录下的Plugins目录下
	private static extern char MotionDetect( System.IntPtr str, ref int nNum, int nChannels ); 

	// 原函数如下：
	// extern "C" _declspec(dllexport) char MotionDetect(char* cstr, int *nNum, int nChannels)
	// {
	// 	*nNum = nChannels;
	// 	return cstr[1];
	// }

	void Awake () {
		int refNum = 0;

		string stringA = "hvvello world";
		System.IntPtr sptr = Marshal.StringToHGlobalAnsi(stringA);

		char retVal = MotionDetect (sptr, ref refNum, 8);
		print (refNum);
		print (retVal);
		Marshal.FreeHGlobal(sptr);
	}

}

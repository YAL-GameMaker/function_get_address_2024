using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace function_get_address_cs {
    public class function_get_address_cs {
        static YYFuncTools.YYFunc script_execute = null;

        [DllExport]
        public static unsafe void dllcs_test_call_func(void* fun) {
            var cf = YYFuncTools.FromPtr((IntPtr)fun);
            var csArgs = new RValue[] {
                RValue.Real(42)
            };
            fixed (RValue* args = csArgs) {
                var result = new RValue();
                cf(&result, IntPtr.Zero, IntPtr.Zero, 1, args);
			}
        }

        [DllExport]
        public static unsafe void dllcs_test_store_script_execute(void* fun) {
            script_execute = YYFuncTools.FromPtr((IntPtr)fun);
		}

        [DllExport]
        public static unsafe double dllcs_test_call_script(double index) {
            var args = new RValue[] {
                RValue.Real(index),
                RValue.Real(1),
                RValue.Real(2),
            };
            var results = new RValue[1];
            fixed (RValue* pArgs = args, pResults = results) {
                var result = new RValue();
                script_execute(&result, IntPtr.Zero, IntPtr.Zero, args.Length, pArgs);
                return result.toReal();
            }
        }
    }
}
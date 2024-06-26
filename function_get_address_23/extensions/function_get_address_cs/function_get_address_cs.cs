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
}﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace function_get_address_cs {
	public class RValueKind {
		public const int Real = 0;
		public const int String = 1;
		public const int Array = 2;
		public const int Ptr = 3;
		public const int Undefined = 5;
		public const int Object = 6;
		public const int Int32 = 7;
		public const int Int64 = 10;
		public const int Null = 12;
		public const int Bool = 13;
		public const int Ref = 15;
		public const int Mask = 0x0ffffff;
	}
	[StructLayout(LayoutKind.Explicit)]
	unsafe public struct RValue {
		[FieldOffset(0)] public int v32;
		[FieldOffset(0)] public long v64;
		[FieldOffset(0)] public double val;
		[FieldOffset(0)] public void* ptr;
		[FieldOffset(8)] public int flags;
		[FieldOffset(12)] public int kind;
		public double toReal() {
			switch (kind & RValueKind.Mask) {
				case RValueKind.Real: return val;
				case RValueKind.Int32: return v32;
				case RValueKind.Int64: return (double)v64;
				case RValueKind.Bool: return val != 0 ? 1 : 0;
				default: return 0;
			}
		}

		public static RValue Real(double val) {
			var rv = new RValue();
			rv.val = val;
			rv.flags = 0;
			rv.kind = RValueKind.Real;
			return rv;
		}
	}
	unsafe public class YYFuncTools {
		public delegate void YYFunc(RValue* result, IntPtr self, IntPtr other, int argc, RValue* arg);
		public static YYFunc FromPtr(IntPtr ptr) {
			return Marshal.GetDelegateForFunctionPointer<YYFunc>(ptr);
		}
	}
}

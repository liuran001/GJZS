package gjzs.online;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Build;
import android.os.IBinder;
import android.os.Parcel;
import android.system.Os;
import android.util.Log;

import org.lsposed.hiddenapibypass.HiddenApiBypass;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Objects;

public class SignCheck {
    private final Context context;
    private String cer = null;
    private String realCer = null;
    private static final String TAG = "SignCheck";

    public SignCheck(Context context) {
        this.context = context;
        this.cer = getCertificateSHA1Fingerprint();
    }

    public SignCheck(Context context, String realCer) {
        this.context = context;
        this.realCer = realCer;
        this.cer = getCertificateSHA1Fingerprint();
    }

    public String getRealCer() {
        return realCer;
    }

    /**
     * 设置正确的签名
     *
     */
    public void setRealCer(String realCer) {
        this.realCer = realCer;
    }

    private byte[] getBytesSHA1(byte[] bytes) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.update(bytes);
            return digest.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    private String getSHA1SignFromPackageInfo(PackageInfo info) {
        Signature[] signatures;
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
            signatures = info.signatures;
        } else {
            signatures = info.signingInfo.getApkContentsSigners();
        }
        if (signatures != null && signatures.length > 0) {
            return byte2HexFormatted(Objects.requireNonNull(getBytesSHA1(signatures[0].toByteArray())));
        }
        throw new RuntimeException("???");
    }

    private static int getTransactionId(String className, String transactionName) throws Throwable {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            HiddenApiBypass.setHiddenApiExemptions("");
        }
        Field declaredField = Class.forName(className).getDeclaredField(transactionName);
        declaredField.setAccessible(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            HiddenApiBypass.clearHiddenApiExemptions();
        }
        return declaredField.getInt(null);
    }

    private static int getCurrentUser() {
        return Os.geteuid() / 100000;
    }

    private PackageInfo getPackageInfo() {
        int flag = Build.VERSION.SDK_INT < Build.VERSION_CODES.P ? PackageManager.GET_SIGNATURES : PackageManager.GET_SIGNING_CERTIFICATES;
        PackageManager pm = context.getPackageManager();
        try {
            return pm.getPackageInfo(context.getPackageName(), flag);
        } catch (Throwable tr) {
            return null;
        }
    }

    @SuppressLint({"BlockedPrivateApi", "DiscouragedPrivateApi", "PrivateApi"})
    private PackageInfo getPackageInfoInternal() throws Throwable {
        Parcel data = Parcel.obtain();
        Parcel reply = Parcel.obtain();
        try {
            Class<?> serviceManagerClazz = Class.forName("android.os.ServiceManager");
            Method getServiceMethod = serviceManagerClazz.getDeclaredMethod("getService", String.class);
            getServiceMethod.setAccessible(true);
            IBinder binder = (IBinder) getServiceMethod.invoke(null, "package");
            Class<?> stubClazz = Class.forName("android.content.pm.IPackageManager$Stub");
            Method getDefaultImplMethod;
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
                getDefaultImplMethod = stubClazz.getDeclaredMethod("getDefaultImpl");
            } else {
                getDefaultImplMethod = HiddenApiBypass.getDeclaredMethod(stubClazz, "getDefaultImpl");
            }
            getDefaultImplMethod.setAccessible(true);
            Object defaultImpl = getDefaultImplMethod.invoke(null);
            Class<?> iPackageManagerClazz = Class.forName("android.content.pm.IPackageManager");
            Method getPackageInfoMethod;
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
                getPackageInfoMethod = iPackageManagerClazz.getDeclaredMethod("getPackageInfo", String.class, int.class, int.class);
            } else {
                getPackageInfoMethod = HiddenApiBypass.getDeclaredMethod(iPackageManagerClazz, "getPackageInfo", String.class, int.class, int.class);
            }
            getPackageInfoMethod.setAccessible(true);

            PackageInfo result;
            data.writeInterfaceToken("android.content.pm.IPackageManager");
            data.writeString(context.getPackageName());
            int flag = Build.VERSION.SDK_INT < Build.VERSION_CODES.P ? PackageManager.GET_SIGNATURES : PackageManager.GET_SIGNING_CERTIFICATES;
            data.writeInt(flag);
            data.writeInt(getCurrentUser());
            boolean status = binder.transact(getTransactionId("android.content.pm.IPackageManager$Stub", "TRANSACTION_getPackageInfo"), data, reply, 0);
            if (!status && defaultImpl != null) {
                Log.e(TAG, "Parcel transact failed");
                return (PackageInfo) getPackageInfoMethod.invoke(defaultImpl, context.getPackageName(), flag, getCurrentUser());
            }
            reply.readException();
            if (reply.readInt() != 0) {
                result = PackageInfo.CREATOR.createFromParcel(reply);
            } else {
                result = null;
            }
            return result;
        } catch (Throwable tr) {
            Log.e(TAG, Log.getStackTraceString(tr));
            throw tr;
        } finally {
            data.recycle();
            reply.recycle();
        }
    }


    /**
     * 获取应用的签名
     *
     */
    public String getCertificateSHA1Fingerprint() {
        PackageInfo packageInfo;
        try {
            packageInfo = getPackageInfoInternal();
        } catch (Throwable tr) {
            packageInfo = getPackageInfo();
        }
        if (packageInfo == null) {
            throw new RuntimeException("???");
        }
        Log.e(TAG, (getSHA1SignFromPackageInfo(packageInfo)));
        return (getSHA1SignFromPackageInfo(packageInfo));
    }

    //这里是将获取到得编码进行16 进制转换
    private String byte2HexFormatted(byte[] arr) {

        StringBuilder str = new StringBuilder(arr.length * 2);

        for (int i = 0; i <arr.length; i++) {
            String h = Integer.toHexString(arr[i]);
            int l =h.length();
            if (l == 1)
                h = "0" + h;
            if (l > 2)
                h = h.substring(l - 2, l);
            str.append(h.toUpperCase());
            if (i < (arr.length - 1))
                str.append(':');
        }
        return str.toString();
    }

    /**
     * 检测签名是否正确
     * @return true 签名正常 false 签名不正常
     */
    public boolean check() {
        if (this.realCer != null) {
            cer = cer.trim();
            realCer = realCer.trim();
            return this.cer.equals(this.realCer);
        } else {
            Log.e(TAG, "real sign is null");
        }
        return false;
    }
}


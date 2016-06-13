# Class: varnish::params
#
# This class sets parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#
class varnish::params {
  $varnish_package_ensure = 'latest'

  case $::osfamily {
    'Debian', 'RedHat': {
      $varnish_package = 'varnish'

      group { 'varnish':
        ensure => present,
        gid    => 241,
      }
    
      user { 'varnish':
        ensure => present,
        gid    => 241,
        home   => '/var/lib/varnish',
        shell  => '/sbin/nologin',
        uid    => 241,
      }

      user { 'varnishlog':
        ensure => present,
        gid    => 241,
        home   => '/var/lib/varnish',
        shell  => '/sbin/nologin',
        uid    => 242,
      }    
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  case $::operatingsystem {
    'Amazon': {
      $varnish_service = [
        'varnish',
        'varnishncsa'
      ]

      file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\
Version: GnuPG v1.4.10 (GNU/Linux)\n\n\
mQINBEyHLzoBEACwWIEvQ1PysbHP1zxMaRzcKC1+ZzIOB7yt59obMxgr+leU/wxq\n\
goKN4BmqZMwCBU7XsqjSAG2AOT/7+uAX28Y/OjC/j+L5vVpPCGwUbD7did6LsFo+\n\
7Dx9Fi28G0YnfLBrmnHDsZb6xSbQiAg70knLVtHRy34a4JKluMKFJKSFdwyVGAZ0\n\
NBMXD0zaMYgMMgKiYJ+/N7oEyeFx8/rmdczTXMO19SNtxmXkLxzr9ch4GbIRL8XZ\n\
OA7fehj2RmBoS2S3x+/mHwsN+nOIq6cRZMZFpHYb6FI/ORZJuuXaJs9J97Q2SnZU\n\
BtSihUjAtT+oUG3AyHIO8YUxirw/iyFDWvJjlAkzKlsU4TJ5FkgH4O2IDdVUTYI7\n\
nW8Emu1hH60GvOq5K9tzs2sONTegVdZ1J5s1+h+xU4fvRzdbmxNCGdtFX2Gy+uri\n\
Eo1iWtqpbWq3OAeZMDd/4HNm05Oc9N5veiSMzvNiXNWUDTLDQwrwUrfPJhWGbcAa\n\
1RtdfkxQFIjjoLvnnnpdV3YNCkuGT2srVefLsIIwGekW9I0VLAiiosf3eWZlNjHw\n\
t5GZsHvDzGa12YXpjRuNV3+6mJ2w8GGCYTOdCs7kRzzSSOesP3gQ+DdbotTS9JR/\n\
rl19yMoOb2UkeM6Fdo72TH/csCphHO4Wn2//MDFmVR9YazbpGRO013qPPwARAQAB\n\
tEB2YXJuaXNoLWNhY2hlLm9yZyByZXBvc2l0b3J5IGtleSA8c3lzYWRtaW5AdmFy\n\
bmlzaC1zb2Z0d2FyZS5jb20+iQJBBBMBCAArBQJMhy86AhsDBQkSzAMABwsHCQgK\n\
BAIHFQoJCAsDAgUWAQIDAAIeAQIXgAAKCRBg58CWxN7/60tMD/0WQOEZsbKAEZhE\n\
m4OJ4eAZTzxyx+l4jZRABW/cBTFkxNlll/Vm20I9KXXawNqRWxlGPyuF3a1JYCXi\n\
cMK2In2y5qpm/J9CVjfVGpdSJAqO52Rz0VWCSFKRuDIg2LK2s+M4uL+bZCCEj/Ih\n\
VOrzdjB6KIReBtzFuf7hoKoi8Bqt+uRGGlycIzkgsUXggvoICK+aVU+oVE0Xmotz\n\
KWjilz9h+b5xtMEkcp3O2x2i/ZlDbQy/6R+Lz2zl6L+nkVUMw9vpkL/R4SH7AikY\n\
+GhZWABMFMA84E6Ss0VqRg8ICbCVRUmAITYfkd7h5maHnTqMeKJCmwFV/3bkHBk7\n\
yANRhyd/gII6fSHJA+yCrpGjUkGKy1C0izpXRJR9egGOVZ8WlFQs+6/hHHd9Zs50\n\
wfd5+U+5BuCWVv9AXEwbm+uP+rOOhJHduiN6UgMV7QGxWIgnBiBPGywpDBeu0i0F\n\
PeIqvxA1OqVgZUhexTWRNd+9TQtnPvxNawn1YQY0OE13Q2ClTC/lZskLSWpD3La3\n\
/tXOQt8hV7evOzkAzAaIiNQxQYEK+K7QlV6hlErwmQ5AeuzlDEs29dQoKPHVzFxR\n\
vPD4N7vt5GtXFkZOACH3TVbO9nmMTBHkOaeKEDqkmt0JJBkiP1cSzc00AQNnZON1\n\
kveIfO1K2Ay4Ya1ZDwL5ee5L6tsDzg==\n\
=G792\n\
-----END PGP PUBLIC KEY BLOCK-----"
      }

      file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH-SOFTWARE':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\
Version: GnuPG v1\n\n\
mQENBE85G24BCADo2RD63+HuqxF6HAjTBKiMp7lz9jTBxkYxfbdilT8K63oiRo0r\n\
0lHn/5/MIVzXikd/6ZW9KubWiAuDOI8S4m+2pq5yUZFJ06UmfPNr7CLa3n6eqYiC\n\
SL9boii6+X2cno2KGinOZBkphVg0y0ClrgUBMKiLrAruYmCDQL5jbgv3YPVWSexY\n\
SojiKno9qvLfWZ84PCVD3opMd+9Z11m8Vs/fVOhg09p2y1JmK6jnwnTk+mJveFNg\n\
MBzRVIvmQdU0CyjKku7EApwWjNTN/aNpNb8tr1j78l1HR4SDDvJUNbu8P2iehMZb\n\
x3IWvk82LhuvnwqN3DaIyVVVSiowHvQxSvq/ABEBAAG0OVZhcm5pc2ggU29mdHdh\n\
cmUgcmVwbyBrZXkgPHN5c2FkbWluQHZhcm5pc2gtc29mdHdhcmUuY29tPokBPgQT\n\
AQIAKAUCTzkbbgIbAwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ\n\
Ln3tNE3t1yGFGggAv4CA0gPKaK0WbA5MQDZUtOxs9qS2+i5ECZC0ueSOtKutjd+z\n\
f96uiaT7odXogaJqd8gy1aShR/+0vAAt7b6GgDwDju+ELZLlVXUH6yjGdIMGyfFO\n\
jEh93bpuIfhvBvjWB5vIHcFmDzgGqn7Umc/Sl4hbJOlhNxqJcvDpDPpoXs55b9EC\n\
mnIuABVWRDU3HX3h4KhLAcIA21I3OuAduse5yH/lntTOMqJwN12X9FFNSTdqQ6uK\n\
0RaR9epNui+LrkihzEDezT23Ho2Ij2JAB/JuZDJwdGqAmHSUShZ1f64jkfTj3HEh\n\
oAbEMxz+VJ/i0OTCC7GCigfTV/81/UxnqxbOt7kBDQRPORtuAQgAviq1ZrCSL1h5\n\
7vIgFnN0AUHZkk8oQF83HLKUWX8VzoHsJJDDAvLYvEEz7474y+aVQhOOR9L0TusX\n\
2RB8ASbmyEYjBcLkUg0ZkuPDaWGOFIt+UxY5HDmGnm4u7iEhspKGaF7pGTlbZNX9\n\
qxkMzFAo/Btx3+uFflyuSqtyMyzNotN8ArZvBG1a17SR/gTcc21Viq3uXSqimAGC\n\
U74xeZK3OilVIMANPyxXiH7zVNPwbKyzX7mQjkLU+9xJiDHWS+gZFKOtOTMg6ppE\n\
dRswrRxI5B4aFwUjjRRVB0tbo0k8+vAuQxmRHrAXOH25fzS2gVFiJFFLz4oi3jne\n\
/V/8lGihsQARAQABiQElBBgBAgAPBQJPORtuAhsMBQkJZgGAAAoJEC597TRN7dch\n\
qv8IALjpeFbNcx/SNwyzUPFna2TykJPabD4npd4BmaZjwLKExU1lghNMwe3tnMf3\n\
G2RF7kOQuHOQ1M+xjRl4aLDaEureFu3tZrVEJ/Ez4htJlDQKDrXu8SjU6qQHsgL5\n\
NWZDEgO+jbDQmgTAHQ3juMD4++5QsOI5OTOsd09sgnolBCr1hONp3RsBjakjIRXq\n\
KA0TiruZhhTNjpZSuxmb1J3GbcqIeu/vPmKACtHP/zQ+SiNz7ZIKdYGUDlsB4Wiq\n\
awQTS99LG0kXV24BXM+RL9F6N+GfMz72h+NwUHLxzmQ51BvQ7AyuwZ9TCtNd2Dq3\n\
AOM9490ZqvQKTgieZ5T9es4zw0Y=\n\
=6AJK\n\
-----END PGP PUBLIC KEY BLOCK-----"
      }

      yumrepo { 'varnish':
        baseurl        => "https://repo.varnish-cache.org/redhat/varnish-${varnish_version}/el${::operatingsystemmajrelease}/${::hardwaremodel}",
        failovermethod => 'priority',
        enabled        => '1',
        gpgcheck       => '1',
        gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH',
        descr          => "Varnish ${varnish_version} for Enterprise Linux",
        require        => File[
          '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH',
          '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH-SOFTWARE'
        ]
      }
    }
    'CentOS', 'OracleLinux', 'RedHat': {
      case $::operatingsystemmajrelease {
        '6','7': {
          $varnish_version = '4.1

          $varnish_package = 'varnish'
    
          $varnish_service = [
            'varnish',
            'varnishncsa'
          ]
    
          file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH':
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\
Version: GnuPG v1.4.10 (GNU/Linux)\n\n\
mQINBEyHLzoBEACwWIEvQ1PysbHP1zxMaRzcKC1+ZzIOB7yt59obMxgr+leU/wxq\n\
goKN4BmqZMwCBU7XsqjSAG2AOT/7+uAX28Y/OjC/j+L5vVpPCGwUbD7did6LsFo+\n\
7Dx9Fi28G0YnfLBrmnHDsZb6xSbQiAg70knLVtHRy34a4JKluMKFJKSFdwyVGAZ0\n\
NBMXD0zaMYgMMgKiYJ+/N7oEyeFx8/rmdczTXMO19SNtxmXkLxzr9ch4GbIRL8XZ\n\
OA7fehj2RmBoS2S3x+/mHwsN+nOIq6cRZMZFpHYb6FI/ORZJuuXaJs9J97Q2SnZU\n\
BtSihUjAtT+oUG3AyHIO8YUxirw/iyFDWvJjlAkzKlsU4TJ5FkgH4O2IDdVUTYI7\n\
nW8Emu1hH60GvOq5K9tzs2sONTegVdZ1J5s1+h+xU4fvRzdbmxNCGdtFX2Gy+uri\n\
Eo1iWtqpbWq3OAeZMDd/4HNm05Oc9N5veiSMzvNiXNWUDTLDQwrwUrfPJhWGbcAa\n\
1RtdfkxQFIjjoLvnnnpdV3YNCkuGT2srVefLsIIwGekW9I0VLAiiosf3eWZlNjHw\n\
t5GZsHvDzGa12YXpjRuNV3+6mJ2w8GGCYTOdCs7kRzzSSOesP3gQ+DdbotTS9JR/\n\
rl19yMoOb2UkeM6Fdo72TH/csCphHO4Wn2//MDFmVR9YazbpGRO013qPPwARAQAB\n\
tEB2YXJuaXNoLWNhY2hlLm9yZyByZXBvc2l0b3J5IGtleSA8c3lzYWRtaW5AdmFy\n\
bmlzaC1zb2Z0d2FyZS5jb20+iQJBBBMBCAArBQJMhy86AhsDBQkSzAMABwsHCQgK\n\
BAIHFQoJCAsDAgUWAQIDAAIeAQIXgAAKCRBg58CWxN7/60tMD/0WQOEZsbKAEZhE\n\
m4OJ4eAZTzxyx+l4jZRABW/cBTFkxNlll/Vm20I9KXXawNqRWxlGPyuF3a1JYCXi\n\
cMK2In2y5qpm/J9CVjfVGpdSJAqO52Rz0VWCSFKRuDIg2LK2s+M4uL+bZCCEj/Ih\n\
VOrzdjB6KIReBtzFuf7hoKoi8Bqt+uRGGlycIzkgsUXggvoICK+aVU+oVE0Xmotz\n\
KWjilz9h+b5xtMEkcp3O2x2i/ZlDbQy/6R+Lz2zl6L+nkVUMw9vpkL/R4SH7AikY\n\
+GhZWABMFMA84E6Ss0VqRg8ICbCVRUmAITYfkd7h5maHnTqMeKJCmwFV/3bkHBk7\n\
yANRhyd/gII6fSHJA+yCrpGjUkGKy1C0izpXRJR9egGOVZ8WlFQs+6/hHHd9Zs50\n\
wfd5+U+5BuCWVv9AXEwbm+uP+rOOhJHduiN6UgMV7QGxWIgnBiBPGywpDBeu0i0F\n\
PeIqvxA1OqVgZUhexTWRNd+9TQtnPvxNawn1YQY0OE13Q2ClTC/lZskLSWpD3La3\n\
/tXOQt8hV7evOzkAzAaIiNQxQYEK+K7QlV6hlErwmQ5AeuzlDEs29dQoKPHVzFxR\n\
vPD4N7vt5GtXFkZOACH3TVbO9nmMTBHkOaeKEDqkmt0JJBkiP1cSzc00AQNnZON1\n\
kveIfO1K2Ay4Ya1ZDwL5ee5L6tsDzg==\n\
=G792\n\
-----END PGP PUBLIC KEY BLOCK-----"
          }
    
          file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH-SOFTWARE':
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\
Version: GnuPG v1\n\n\
mQENBE85G24BCADo2RD63+HuqxF6HAjTBKiMp7lz9jTBxkYxfbdilT8K63oiRo0r\n\
0lHn/5/MIVzXikd/6ZW9KubWiAuDOI8S4m+2pq5yUZFJ06UmfPNr7CLa3n6eqYiC\n\
SL9boii6+X2cno2KGinOZBkphVg0y0ClrgUBMKiLrAruYmCDQL5jbgv3YPVWSexY\n\
SojiKno9qvLfWZ84PCVD3opMd+9Z11m8Vs/fVOhg09p2y1JmK6jnwnTk+mJveFNg\n\
MBzRVIvmQdU0CyjKku7EApwWjNTN/aNpNb8tr1j78l1HR4SDDvJUNbu8P2iehMZb\n\
x3IWvk82LhuvnwqN3DaIyVVVSiowHvQxSvq/ABEBAAG0OVZhcm5pc2ggU29mdHdh\n\
cmUgcmVwbyBrZXkgPHN5c2FkbWluQHZhcm5pc2gtc29mdHdhcmUuY29tPokBPgQT\n\
AQIAKAUCTzkbbgIbAwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ\n\
Ln3tNE3t1yGFGggAv4CA0gPKaK0WbA5MQDZUtOxs9qS2+i5ECZC0ueSOtKutjd+z\n\
f96uiaT7odXogaJqd8gy1aShR/+0vAAt7b6GgDwDju+ELZLlVXUH6yjGdIMGyfFO\n\
jEh93bpuIfhvBvjWB5vIHcFmDzgGqn7Umc/Sl4hbJOlhNxqJcvDpDPpoXs55b9EC\n\
mnIuABVWRDU3HX3h4KhLAcIA21I3OuAduse5yH/lntTOMqJwN12X9FFNSTdqQ6uK\n\
0RaR9epNui+LrkihzEDezT23Ho2Ij2JAB/JuZDJwdGqAmHSUShZ1f64jkfTj3HEh\n\
oAbEMxz+VJ/i0OTCC7GCigfTV/81/UxnqxbOt7kBDQRPORtuAQgAviq1ZrCSL1h5\n\
7vIgFnN0AUHZkk8oQF83HLKUWX8VzoHsJJDDAvLYvEEz7474y+aVQhOOR9L0TusX\n\
2RB8ASbmyEYjBcLkUg0ZkuPDaWGOFIt+UxY5HDmGnm4u7iEhspKGaF7pGTlbZNX9\n\
qxkMzFAo/Btx3+uFflyuSqtyMyzNotN8ArZvBG1a17SR/gTcc21Viq3uXSqimAGC\n\
U74xeZK3OilVIMANPyxXiH7zVNPwbKyzX7mQjkLU+9xJiDHWS+gZFKOtOTMg6ppE\n\
dRswrRxI5B4aFwUjjRRVB0tbo0k8+vAuQxmRHrAXOH25fzS2gVFiJFFLz4oi3jne\n\
/V/8lGihsQARAQABiQElBBgBAgAPBQJPORtuAhsMBQkJZgGAAAoJEC597TRN7dch\n\
qv8IALjpeFbNcx/SNwyzUPFna2TykJPabD4npd4BmaZjwLKExU1lghNMwe3tnMf3\n\
G2RF7kOQuHOQ1M+xjRl4aLDaEureFu3tZrVEJ/Ez4htJlDQKDrXu8SjU6qQHsgL5\n\
NWZDEgO+jbDQmgTAHQ3juMD4++5QsOI5OTOsd09sgnolBCr1hONp3RsBjakjIRXq\n\
KA0TiruZhhTNjpZSuxmb1J3GbcqIeu/vPmKACtHP/zQ+SiNz7ZIKdYGUDlsB4Wiq\n\
awQTS99LG0kXV24BXM+RL9F6N+GfMz72h+NwUHLxzmQ51BvQ7AyuwZ9TCtNd2Dq3\n\
AOM9490ZqvQKTgieZ5T9es4zw0Y=\n\
=6AJK\n\
-----END PGP PUBLIC KEY BLOCK-----"
          }
    
          yumrepo { 'varnish':
            baseurl        => "https://repo.varnish-cache.org/redhat/varnish-${varnish_version}/el${::operatingsystemmajrelease}/${::hardwaremodel}",
            failovermethod => 'priority',
            enabled        => '1',
            gpgcheck       => '1',
            gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH',
            descr          => "Varnish ${varnish_version} for Enterprise Linux",
            require        => File[
              '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH',
              '/etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH-SOFTWARE'
            ]
          }
          default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemmajrelease} distribution.")
        }
      }
    }
    'Debian': {
      case $::operatingsystemmajrelease {
        '8': {
          $varnish_package = 'varnish'

          $varnish_service = [
            'varnish',
            'varnishncsa'
          ]
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemmajrelease} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
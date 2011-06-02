#! /usr/bin/env ruby
require 'rubygems'
require 'fffs'

fs = FFFS::FileSystem.parse(File.read(ARGV.first).split(/^__END__$/)[1])

describe FFFS do
  describe '/file' do
    it 'has the right content' do
      fs['/file'].to_s.should == "bla bla bla bla\nblablabla\nblablablablab lab lab la"
    end
  end

  describe '/dir' do
    it 'has #length 2' do
      fs['/dir'].length.should == 2
    end

    describe '/file' do
      it 'has the right content' do
        fs['/dir/file'].to_s.should == ':3'
      end
    end

    describe '/binary' do
      it 'has image/png mime type' do
        fs['/dir/binary'].mime.should == 'image/png'
      end

      it 'is really a PNG' do
        fs['/dir/binary'].content[0 ... 4].should == "\x89PNG"
      end
    end
  end
end

__END__
---

--- file ---

bla bla bla bla
blablabla
blablablablab lab lab la

--- dir/file ---

:3

--- dir/binary (image/png) ---

iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAMAAACVQ462AAAABGdBTUEAALGP
C/xhBQAAAwBQTFRFAAAAHxALIxcJJBgIJBgKJhgLJhoKJxsLJhoMKBsKKBsL
KBoNKBwLKRwMKh0NKx4NKx4OLR0OLB4OLx8PLB4RLyANLSAQLyIRMiMQMyQR
NCUSOigUPyoVKCgoPz8/JiFbMChyAFtbAGBgAGhoAH9/Qh0KQSEMRSIOQioS
UigmUTElYkMvbUMqb0UsakAwdUcvdEgvek4za2trOjGJUj2JRjqlVknMAJmZ
AJ6eAKioAK+vAMzMikw9gFM0hFIxhlM0gVM5g1U7h1U7h1g6ilk7iFo5j14+
kF5Dll9All9BmmNEnGNFnGNGmmRKnGdIn2hJnGlMnWpPlm9bnHJcompHrHZa
qn1ms3titXtnrYBttIRttolsvohst4Jyu4lyvYtyvY5yvY50xpaA////AAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAPSUN6AAAAQB0Uk5T////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////AFP3ByUAAAAYdEVYdFNvZnR3YXJlAFBhaW50Lk5FVCB2
My4zNqnn4iUAAAKjSURBVEhLpZSLVtNAEIYLpSlLSUITLCBaGhNBQRM01M2m
SCoXNUURIkZFxQvv/wz6724Wij2HCM7J6UyS/b+dmZ208rsww6jiqo4Fhann
Zb5yDqjaNgDVwE/8JAmCMqF6fwGwbU0CKjD/+oAq9jcM27gxAFpNQxU3Bwi9
Ajy8fgmGZuvaGAcIuwFA12CGce1jJESr6/Ot1i3Tnq5qptFqzet1jRA1F2XH
WQFAs3RzwTTNhQd3rOkFU7c0DijmohRg1TR9ZmpCN7/8+PX954fb+sTUjK7V
LKOYi1IAaTQtUrfm8pP88/vTw8M5q06sZoOouSgHEDI5vrO/eHK28el04yxf
3N8ZnyQooZiLfwA0arNb6d6bj998/+vx8710a7bW4E2Uc1EKsEhz7WiQBK9e
L29urrzsB8ngaK1JLDUXpYAkGSQH6e7640fL91dWXjxZ33138PZggA+Sz0WQ
lAL4gmewuzC1uCenqXevMPWc9XrMX/VXh6Hicx4ByHEeAfRg/wtgSMAvz+CK
EkYAnc5SpwuD4z70PM+hUf+4348ixF7EGItjxmQcCx/Dzv/SOkuXAF3PdT3G
IujjGLELNYwxhF7M4oi//wsgdlYZdMXCmEUUSsSu0OOBACMoBTiu62BdRPEj
YxozXFyIpK7IAE0IYa7jOBRqGlOK0BFq3Kdpup3DthFwP9QDlBCGKEECoHEB
EDLAXHAQMQnI8jwFYRQw3AMOQAJoOADoAVcDAh0HZAKQZUMZdC43kdeqAPwU
BEsC+M4cIEq5KEEBCl90mR8CVR3nxwCdBBS9OAe020UGnXb7KcxzPY9SXoEE
IBZtgE7UDgBKyLMhgBS2YdzjMJb4XHRDAPiQhSGjNOxKQIZTgC8BiMECgarx
prjjO0OXiV4MAf4A/x0nbcyiS5EAAAAASUVORK5CYII=

<!-- Output copied to clipboard! -->

<!-----

Yay, no errors, warnings, or alerts!

Conversion time: 0.489 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β33
* Thu Feb 10 2022 02:06:20 GMT-0800 (PST)
* Source doc: CDN prewarm setup
* Tables are currently converted to HTML tables.

WARNING:
You have 2 H1 headings. You may want to use the "H1 -> H2" option to demote all headings by one level.

----->


<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 1; ALERTS: 0.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p>
<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>



# 
CDN预热脚本效果说明


### 
第一次，Edge无缓存 100 1455k 100 1455k 0 0 5578k 0 --:--:-- --:--:-- --:--:-- 5578k


### 
A tool to improve file download speed from Google Cloud CDN by pre-fetching hot files from the origin to the CDN cache in the GCP regions, before the clients start downloading them.


### 
The below tests proves the effectiveness of pre-fetching. 以下测试说明预热效果。



* 文件均存储在印度Bucket
* 缓存预热是通过GCE实例请求相应文件
* 文件下载均执行在新加坡EC2

## 
[http://35.244.143.158/googlework_short_1.mp4](http://35.244.143.158/googlework_short_1.mp4) 无预热


### 
curl -v [http://35.244.143.158/googlework_short_1.mp4](http://35.244.143.158/googlework_short_1.mp4) --output file.mp4


### 
第一次，Edge无缓存 100 1455k 100 1455k 0 0 5578k 0 --:--:-- --:--:-- --:--:-- 5578k


### 
第二次，Edge有缓存 100 1455k 100 1455k 0 0 24.9M 0 --:--:-- --:--:-- --:--:-- 24.9M


## 
[http://35.244.143.158/googlework_short_2.mp4](http://35.244.143.158/googlework_short_2.mp4) 在印度区域预热


### 
curl -v [http://35.244.143.158/googlework_short_2.mp4](http://35.244.143.158/googlework_short_2.mp4) --output file.mp4


### 
第一次，Edge无缓存 100 1455k 100 1455k 0 0 5687k 0 --:--:-- --:--:-- --:--:-- 5687k


### 
第二次，Edge有缓存 100 1455k 100 1455k 0 0 43.0M 0 --:--:-- --:--:-- --:--:-- 43.0M


## 
[http://35.244.143.158/googlework_short_3.mp4](http://35.244.143.158/googlework_short_3.mp4) 在新加坡区域预热


### 
curl -v [http://35.244.143.158/googlework_short_3.mp4](http://35.244.143.158/googlework_short_3.mp4) --output file.mp4


### 
第一次，Edge有缓存 100 1455k 100 1455k 0 0 36.4M 0 --:--:-- --:--:-- --:--:-- 37.4M


### 
另外：如果在印度区域预热，从印度EC2访问也可以命中缓存


# 
设置步骤



## Create SSH key


```
ssh-keygen -t rsa -f ~/.ssh/prefetch_key -C prefetch
cat ~/.ssh/prefetch_key.pub
```



## 
Update cdn_prefetch/multi-instance.jinja with public key & Network tag(in order to allow ssh in firewall)


## Create GCE deployment


```
gcloud deployment-manager deployments create cdn-prefetch --config cdn-prefetch-config.yaml
```



## Run prefetch.sh


```
bash prefetch.sh <URL>
```


And tail -f result.log for logs.


## Delete GCE deployment (Only run when the service is no longer needed)


```
gcloud deployment-manager deployments delete cdn-prefetch
```

